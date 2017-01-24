﻿-- Generated by CSharp.lua Compiler 1.0.0.0
local System = System;
local Linq = System.Linq.Enumerable;
local CSharpLua;
local CSharpLuaLuaAst;
System.usingDeclare(function (global) 
    CSharpLua = global.CSharpLua;
    CSharpLuaLuaAst = CSharpLua.LuaAst;
end);
System.namespace("CSharpLua.LuaAst", function (namespace) 
    namespace.class("LuaTypeDeclarationSyntax", function (namespace) 
        local AddStaticReadOnlyAssignmentName, AddTypeIdentifier, AddResultTable, AddResultTable1, AddMethod, AddInitFiled, AddInitFiled1, AddField, 
        AddPropertyOrEvent, AddProperty, AddEvent, SetStaticCtor, AddCtor, AddInitFunction, AddStaticAssignmentNames, AddStaticCtorFunction, 
        AddCtorsFunction, AddBaseTypes, Render, __init__, __ctor__;
        AddStaticReadOnlyAssignmentName = function (this, name) 
            if not this.staticAssignmentNames_:Contains(name) then
                this.staticAssignmentNames_:Add(name);
            end
        end;
        AddTypeIdentifier = function (this, identifier) 
            this.typeIdentifiers_:Add(identifier);
        end;
        AddResultTable = function (this, name) 
            local item = CSharpLuaLuaAst.LuaKeyValueTableItemSyntax(CSharpLuaLuaAst.LuaTableLiteralKeySyntax(name), name);
            this.resultTable_.Items:Add1(item);
        end;
        AddResultTable1 = function (this, name, value) 
            local item = CSharpLuaLuaAst.LuaKeyValueTableItemSyntax(CSharpLuaLuaAst.LuaTableLiteralKeySyntax(name), value);
            this.resultTable_.Items:Add1(item);
        end;
        AddMethod = function (this, name, method, isPrivate) 
            this.local_.Variables:Add1(name);
            local assignment = CSharpLuaLuaAst.LuaAssignmentExpressionSyntax(name, method);
            this.methodList_.Statements:Add(CSharpLuaLuaAst.LuaExpressionStatementSyntax(assignment));
            if not isPrivate then
                AddResultTable(this, name);
            end
        end;
        AddInitFiled = function (this, initFunction, assignment) 
            if initFunction == nil then
                initFunction = CSharpLuaLuaAst.LuaFunctionExpressionSyntax();
                initFunction:AddParameter(CSharpLuaLuaAst.LuaIdentifierNameSyntax.This);
            end
            initFunction:AddStatement1(assignment);
        end;
        AddInitFiled1 = function (this, initFunction, name, value) 
            local memberAccess = CSharpLuaLuaAst.LuaMemberAccessExpressionSyntax(CSharpLuaLuaAst.LuaIdentifierNameSyntax.This, name);
            local assignment = CSharpLuaLuaAst.LuaAssignmentExpressionSyntax(memberAccess, value);
            initFunction = AddInitFiled(this, initFunction, assignment);
        end;
        AddField = function (this, name, value, isImmutable, isStatic, isPrivate, isReadOnly) 
            if isStatic then
                if isPrivate then
                    this.local_.Variables:Add1(name);
                    if value ~= nil then
                        local assignment = CSharpLuaLuaAst.LuaAssignmentExpressionSyntax(name, value);
                        if isImmutable then
                            this.methodList_.Statements:Add(CSharpLuaLuaAst.LuaExpressionStatementSyntax(assignment));
                        else
                            this.staticInitFunction_ = AddInitFiled(this, this.staticInitFunction_, assignment);
                        end
                    end
                else
                    if isReadOnly then
                        this.local_.Variables:Add1(name);
                        if value ~= nil then
                            local assignment = CSharpLuaLuaAst.LuaAssignmentExpressionSyntax(name, value);
                            if isImmutable then
                                this.methodList_.Statements:Add(CSharpLuaLuaAst.LuaExpressionStatementSyntax(assignment));
                                AddResultTable(this, name);
                            else
                                this.staticInitFunction_ = AddInitFiled(this, this.staticInitFunction_, assignment);
                                this.staticAssignmentNames_:Add(name.ValueText);
                            end
                        end
                    else
                        if value ~= nil then
                            if isImmutable then
                                AddResultTable1(this, name, value);
                            else
                                this.staticInitFunction_ = AddInitFiled1(this, this.staticInitFunction_, name, value);
                            end
                        end
                    end
                end
            else
                if value ~= nil then
                    if isImmutable then
                        AddResultTable1(this, name, value);
                    else
                        this.initFunction_ = AddInitFiled1(this, this.initFunction_, name, value);
                    end
                end
            end
        end;
        AddPropertyOrEvent = function (this, isProperty, name, value, isImmutable, isStatic, isPrivate) 
            local getToken, setToken;
            local initMethodIdentifier;
            if isProperty then
                getToken = "get" --[[Tokens.Get]];
                setToken = "set" --[[Tokens.Set]];
                initMethodIdentifier = CSharpLuaLuaAst.LuaIdentifierNameSyntax.Property;
            else
                getToken = "add" --[[Tokens.Add]];
                setToken = "remove" --[[Tokens.Remove]];
                initMethodIdentifier = CSharpLuaLuaAst.LuaIdentifierNameSyntax.Event;
            end

            local identifierName = CSharpLuaLuaAst.LuaIdentifierNameSyntax:new(1, name);
            local get = CSharpLuaLuaAst.LuaIdentifierNameSyntax:new(1, (getToken or "") .. (name or ""));
            local set = CSharpLuaLuaAst.LuaIdentifierNameSyntax:new(1, (setToken or "") .. (name or ""));
            this.local_.Variables:Add1(get);
            this.local_.Variables:Add1(set);
            local assignment = CSharpLuaLuaAst.LuaMultipleAssignmentExpressionSyntax();
            assignment.Lefts:Add1(get);
            assignment.Lefts:Add1(set);
            local invocation = CSharpLuaLuaAst.LuaInvocationExpressionSyntax:new(1, initMethodIdentifier);
            invocation:AddArgument(CSharpLuaLuaAst.LuaStringLiteralExpressionSyntax:new(1, identifierName));
            assignment.Rights:Add1(invocation);
            this.methodList_.Statements:Add(CSharpLuaLuaAst.LuaExpressionStatementSyntax(assignment));

            if value ~= nil then
                if isStatic then
                    if isImmutable then
                        AddResultTable1(this, identifierName, value);
                    else
                        this.staticInitFunction_ = AddInitFiled1(this, this.staticInitFunction_, identifierName, value);
                    end
                else
                    if isImmutable then
                        AddResultTable1(this, identifierName, value);
                    else
                        this.initFunction_ = AddInitFiled1(this, this.initFunction_, identifierName, value);
                    end
                end
            end

            if not isPrivate then
                AddResultTable(this, get);
                AddResultTable(this, set);
            end
        end;
        AddProperty = function (this, name, value, isImmutable, isStatic, isPrivate) 
            AddPropertyOrEvent(this, true, name, value, isImmutable, isStatic, isPrivate);
        end;
        AddEvent = function (this, name, value, isImmutable, isStatic, isPrivate) 
            AddPropertyOrEvent(this, false, name, value, isImmutable, isStatic, isPrivate);
        end;
        SetStaticCtor = function (this, function_) 
            assert(this.staticCtorFunction_ == nil);
            this.staticCtorFunction_ = function_;
        end;
        AddCtor = function (this, function_) 
            this.ctors_:Add(function_);
        end;
        AddInitFunction = function (this, name, initFunction, isAddItem) 
            if isAddItem == nil then isAddItem = true end
            local assignment = CSharpLuaLuaAst.LuaAssignmentExpressionSyntax(name, initFunction);
            this.methodList_.Statements:Add(CSharpLuaLuaAst.LuaExpressionStatementSyntax(assignment));
            this.local_.Variables:Add1(name);
            if isAddItem then
                AddResultTable(this, name);
            end
        end;
        AddStaticAssignmentNames = function (this, body) 
            if #this.staticAssignmentNames_ > 0 then
                local assignment = CSharpLuaLuaAst.LuaMultipleAssignmentExpressionSyntax();
                for _, name in System.each(this.staticAssignmentNames_) do
                    local identifierName = CSharpLuaLuaAst.LuaIdentifierNameSyntax:new(1, name);
                    local memberAccess = CSharpLuaLuaAst.LuaMemberAccessExpressionSyntax(CSharpLuaLuaAst.LuaIdentifierNameSyntax.This, identifierName);
                    assignment.Lefts:Add1(memberAccess);
                    assignment.Rights:Add1(identifierName);
                end
                body.Statements:Add1(CSharpLuaLuaAst.LuaExpressionStatementSyntax(assignment));
            end
        end;
        AddStaticCtorFunction = function (this) 
            local hasStaticInit = this.staticInitFunction_ ~= nil;
            local hasStaticCtor = this.staticCtorFunction_ ~= nil;

            if hasStaticCtor then
                if hasStaticInit then
                    this.staticCtorFunction_.Body.Statements:InsertRange(0, this.staticInitFunction_.Body.Statements);
                end
                AddStaticAssignmentNames(this, this.staticCtorFunction_.Body);
                AddInitFunction(this, CSharpLuaLuaAst.LuaIdentifierNameSyntax.StaticCtor, this.staticCtorFunction_);
            else
                if hasStaticInit then
                    AddStaticAssignmentNames(this, this.staticInitFunction_.Body);
                    AddInitFunction(this, CSharpLuaLuaAst.LuaIdentifierNameSyntax.StaticCtor, this.staticInitFunction_);
                end
            end
        end;
        AddCtorsFunction = function (this) 
            local hasInit = this.initFunction_ ~= nil;
            local hasCtors = #this.ctors_ > 0;

            if hasCtors then
                if hasInit then
                    local initIdentifier = CSharpLuaLuaAst.LuaIdentifierNameSyntax.Init;
                    AddInitFunction(this, initIdentifier, this.initFunction_, false);
                    for _, ctor in System.each(this.ctors_) do
                        if not ctor.IsInvokeThisCtor then
                            local invocationInit = CSharpLuaLuaAst.LuaInvocationExpressionSyntax:new(2, initIdentifier, CSharpLuaLuaAst.LuaIdentifierNameSyntax.This);
                            ctor.Body.Statements:Insert(0, CSharpLuaLuaAst.LuaExpressionStatementSyntax(invocationInit));
                        end
                    end
                end

                if #this.ctors_ == 1 then
                    AddInitFunction(this, CSharpLuaLuaAst.LuaIdentifierNameSyntax.Ctor, CSharpLua.Utility.First(this.ctors_, CSharpLuaLuaAst.LuaConstructorAdapterExpressionSyntax));
                else
                    local ctrosTable = CSharpLuaLuaAst.LuaTableInitializerExpression();
                    local index = 1;
                    for _, ctor in System.each(this.ctors_) do
                        local name = CSharpLuaLuaAst.LuaSyntaxNode.SpecailWord("ctor" --[[Tokens.Ctor]] .. index);
                        local nameIdentifier = CSharpLuaLuaAst.LuaIdentifierNameSyntax:new(1, name);
                        AddInitFunction(this, nameIdentifier, ctor, false);
                        ctrosTable.Items:Add1(CSharpLuaLuaAst.LuaSingleTableItemSyntax(nameIdentifier));
                        index = index + 1;
                    end
                    AddResultTable1(this, CSharpLuaLuaAst.LuaIdentifierNameSyntax.Ctor, ctrosTable);
                end
            else
                if hasInit then
                    AddInitFunction(this, CSharpLuaLuaAst.LuaIdentifierNameSyntax.Ctor, this.initFunction_);
                end
            end
        end;
        AddBaseTypes = function (this, baseTypes) 
            local table = CSharpLuaLuaAst.LuaTableInitializerExpression();
            table.Items:AddRange1(Linq.Select(baseTypes, function (i) return CSharpLuaLuaAst.LuaSingleTableItemSyntax(i); end, CSharpLuaLuaAst.LuaSingleTableItemSyntax));
            AddResultTable1(this, CSharpLuaLuaAst.LuaIdentifierNameSyntax.Inherits, table);
        end;
        Render = function (this, renderer) 
            if this.IsPartialMark then
                return;
            end

            this.statements_:Add(this.local_);
            AddStaticCtorFunction(this);
            AddCtorsFunction(this);
            this.statements_:Add(this.methodList_);

            local returnStatement = CSharpLuaLuaAst.LuaReturnStatementSyntax:new(1, this.resultTable_);
            this.statements_:Add(returnStatement);

            if #this.typeIdentifiers_ > 0 then
                local wrapFunction = CSharpLuaLuaAst.LuaFunctionExpressionSyntax();
                for _, type in System.each(this.typeIdentifiers_) do
                    wrapFunction:AddParameter(type);
                end
                wrapFunction:AddStatements(this.statements_);
                this.statements_:Clear();
                this.statements_:Add(CSharpLuaLuaAst.LuaReturnStatementSyntax:new(1, wrapFunction));
            end
            CSharpLuaLuaAst.LuaWrapFunctionStatementSynatx.Render(this, renderer);
        end;
        __init__ = function (this) 
            this.local_ = CSharpLuaLuaAst.LuaTypeLocalAreaSyntax();
            this.methodList_ = CSharpLuaLuaAst.LuaStatementListSyntax();
            this.resultTable_ = CSharpLuaLuaAst.LuaTableInitializerExpression();
            this.staticAssignmentNames_ = System.List(System.String)();
            this.ctors_ = System.List(CSharpLuaLuaAst.LuaConstructorAdapterExpressionSyntax)();
            this.typeIdentifiers_ = System.List(CSharpLuaLuaAst.LuaIdentifierNameSyntax)();
        end;
        __ctor__ = function (this) 
            __init__(this);
        end;
        return {
            __inherits__ = {
                CSharpLuaLuaAst.LuaWrapFunctionStatementSynatx
            }, 
            IsPartialMark = False, 
            AddStaticReadOnlyAssignmentName = AddStaticReadOnlyAssignmentName, 
            AddTypeIdentifier = AddTypeIdentifier, 
            AddMethod = AddMethod, 
            AddField = AddField, 
            AddProperty = AddProperty, 
            AddEvent = AddEvent, 
            SetStaticCtor = SetStaticCtor, 
            AddCtor = AddCtor, 
            AddBaseTypes = AddBaseTypes, 
            Render = Render, 
            __ctor__ = __ctor__
        };
    end);
    namespace.class("LuaClassDeclarationSyntax", function (namespace) 
        local __ctor__;
        __ctor__ = function (this, name) 
            this:UpdateIdentifiers(name, CSharpLuaLuaAst.LuaIdentifierNameSyntax.Namespace, CSharpLuaLuaAst.LuaIdentifierNameSyntax.Class, CSharpLuaLuaAst.LuaIdentifierNameSyntax.Namespace);
        end;
        return {
            __inherits__ = {
                CSharpLuaLuaAst.LuaTypeDeclarationSyntax
            }, 
            __ctor__ = __ctor__
        };
    end);
    namespace.class("LuaStructDeclarationSyntax", function (namespace) 
        local __ctor__;
        __ctor__ = function (this, name) 
            this:UpdateIdentifiers(name, CSharpLuaLuaAst.LuaIdentifierNameSyntax.Namespace, CSharpLuaLuaAst.LuaIdentifierNameSyntax.Struct, CSharpLuaLuaAst.LuaIdentifierNameSyntax.Namespace);
        end;
        return {
            __inherits__ = {
                CSharpLuaLuaAst.LuaTypeDeclarationSyntax
            }, 
            __ctor__ = __ctor__
        };
    end);
    namespace.class("LuaInterfaceDeclarationSyntax", function (namespace) 
        local __ctor__;
        __ctor__ = function (this, name) 
            this:UpdateIdentifiers(name, CSharpLuaLuaAst.LuaIdentifierNameSyntax.Namespace, CSharpLuaLuaAst.LuaIdentifierNameSyntax.Interface);
        end;
        return {
            __inherits__ = {
                CSharpLuaLuaAst.LuaTypeDeclarationSyntax
            }, 
            __ctor__ = __ctor__
        };
    end);
    namespace.class("LuaEnumDeclarationSyntax", function (namespace) 
        local Add, Render, __ctor__;
        Add = function (this, statement) 
            this.resultTable_.Items:Add1(statement);
        end;
        Render = function (this, renderer) 
            if this.IsExport then
                CSharpLuaLuaAst.LuaTypeDeclarationSyntax.Render(this, renderer);
            end
        end;
        __ctor__ = function (this, fullName, name, compilationUnit) 
            this.FullName = fullName;
            this.CompilationUnit = compilationUnit;
            this:UpdateIdentifiers(name, CSharpLuaLuaAst.LuaIdentifierNameSyntax.Namespace, CSharpLuaLuaAst.LuaIdentifierNameSyntax.Enum);
        end;
        return {
            __inherits__ = {
                CSharpLuaLuaAst.LuaTypeDeclarationSyntax
            }, 
            IsExport = False, 
            Add = Add, 
            Render = Render, 
            __ctor__ = __ctor__
        };
    end);
end);