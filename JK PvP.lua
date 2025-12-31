local L=game:service("\80\108\97\121\101\114\115")
local O=game:service("\82\117\110\83\101\114\118\105\99\101")
local S=game:service("\85\115\101\114\73\110\112\117\116\83\101\114\118\105\99\101")
local N=game:service("\67\111\114\101\71\117\105")
local C=game:service("\86\105\114\116\117\97\108\73\110\112\117\116\77\97\110\97\103\101\114")
local X=L.LocalPlayer 
if N:FindFirstChild("\74\75\95\86\50\53") then 
    N.JK_V25:Destroy() 
end 

local T=Instance.new("\83\99\114\101\101\110\71\117\105",N)
T.Name="\74\75\95\86\50\53"

_G.JK_Data={
    Speed={Val=25,On=false,ActiveMini=nil},
    Jump={Val=50,On=false,ActiveMini=nil},
    Hit={Val=0.05,On=false,ActiveMini=nil},
    ESP={On=false,ActiveMini=nil}
}

local function M(E,Q)
    local w,I,k 
    w=false,nil,nil 
    Q.InputBegan:Connect(function(F)
        if F.UserInputType==Enum.UserInputType.MouseButton1 or F.UserInputType==Enum.UserInputType.Touch then
            w=true 
            I=F.Position 
            k=E.Position 
        end 
    end)
    
    S.InputChanged:Connect(function(F)
        if w and (F.UserInputType==Enum.UserInputType.MouseMovement or F.UserInputType==Enum.UserInputType.Touch) then
            local G=F.Position-I 
            E.Position=UDim2.new(k.X.Scale,k.X.Offset+G.X,k.Y.Scale,k.Y.Offset+G.Y)
        end 
    end)
    
    S.InputEnded:Connect(function()
        w=false 
    end)
end 

local P=Instance.new("\70\114\97\109\101",T)
P.Size=UDim2.new(0,220,0,240)
P.Position=UDim2.new(0.5,-110,0.5,-120)
P.BackgroundColor3=Color3.new(0,0,0)
P.Name="\77\97\105\110\70\114\97\109\101"
Instance.new("\85\73\67\111\114\110\101\114",P)
Instance.new("\85\73\83\116\114\111\107\101",P).Color=Color3.fromRGB(0,150,255)

local R=Instance.new("\70\114\97\109\101",P)
R.Size=UDim2.new(1,0,0,30)
R.Position=UDim2.new(0,0,0,0)
R.BackgroundTransparency=1 

local H=Instance.new("\84\101\120\116\76\97\98\101\108",R)
H.Size=UDim2.new(1,-60,1,0)
H.Position=UDim2.new(0,0,0,0)
H.Text="\74\75\32\80\118\80"
H.BackgroundTransparency=1 
H.TextColor3=Color3.new(1,1,1)
H.Font=Enum.Font.GothamBold 
H.TextSize=18

local U=Instance.new("\84\101\120\116\66\117\116\116\111\110",R)
U.Size=UDim2.new(0,25,0,25)
U.Position=UDim2.new(1,-60,0,2)
U.Text="_"
U.BackgroundColor3=Color3.fromRGB(100,100,100)
Instance.new("\85\73\67\111\114\110\101\114",U)

local V=Instance.new("\84\101\120\116\66\117\116\116\111\110",R)
V.Size=UDim2.new(0,25,0,25)
V.Position=UDim2.new(1,-30,0,2)
V.Text="X"
V.BackgroundColor3=Color3.fromRGB(150,0,0)
Instance.new("\85\73\67\111\114\110\101\114",V)
V.MouseButton1Click:Connect(function()
    T:Destroy()
end)

M(P,R)

local K={
    Speed={},
    Jump={},
    Hit={},
    ESP={}
}

local function J(Z,h)
    for _,v in pairs(K[Z]) do
        if v.toggleText then
            v.toggleText.TextColor3=Color3.new(1,1,1)
        end
        if v.miniText then
            v.miniText.TextColor3=Color3.new(1,1,1)
        end
    end
    
    if h then
        _G.JK_Data[Z].ActiveMini=h 
        _G.JK_Data[Z].On=true 
        
        if h.toggleText then
            h.toggleText.TextColor3=Color3.new(0,1,0)
        end
        if h.miniText then
            h.miniText.TextColor3=Color3.new(0,1,0)
        end
        
        if (Z=="\83\112\101\101\100" or Z=="\74\117\109\112") and h.value then
            _G.JK_Data[Z].Val=h.value 
        end
    else
        _G.JK_Data[Z].On=false 
        _G.JK_Data[Z].ActiveMini=nil 
    end
end

local function Y(B,y,W,q)
    local D=Instance.new("\70\114\97\109\101",P)
    D.Size=UDim2.new(0.9,0,0,35)
    D.Position=UDim2.new(0.05,0,0,y)
    D.BackgroundColor3=Color3.fromRGB(20,20,20)
    Instance.new("\85\73\67\111\114\110\101\114",D)

    local A=Instance.new("\84\101\120\116\66\117\116\116\111\110",D)
    A.Size=UDim2.new(0,35,0.8,0)
    A.Position=UDim2.new(0,5,0.1,0)
    A.Text="👥"
    A.BackgroundColor3=Color3.fromRGB(0,150,255)
    Instance.new("\85\73\67\111\114\110\101\114",A)
    
    local p 
    if q=="\83\112\101\101\100" or q=="\74\117\109\112" then
        p=Instance.new("\84\101\120\116\66\111\120",D)
        p.Size=UDim2.new(0,45,0.8,0)
        p.Position=UDim2.new(0,45,0.1,0)
        p.Text=tostring(W)
        p.BackgroundColor3=Color3.new(0,0,0)
        p.TextColor3=Color3.new(1,1,1)
        Instance.new("\85\73\67\111\114\110\101\114",p)
    else
        local a=Instance.new("\70\114\97\109\101",D)
        a.Size=UDim2.new(0,45,0.8,0)
        a.Position=UDim2.new(0,45,0.1,0)
        a.BackgroundTransparency=1 
    end
    
    local b=Instance.new("\84\101\120\116\66\117\116\116\111\110",D)
    b.Size=UDim2.new(1,-100,0.8,0)
    b.Position=UDim2.new(0,95,0.1,0)
    b.Text=B 
    b.BackgroundColor3=Color3.fromRGB(30,30,30)
    b.TextColor3=Color3.new(1,1,1)
    Instance.new("\85\73\67\111\114\110\101\114",b)
    
    local u=0 
    
    A.MouseButton1Click:Connect(function()
        local c=W 
        if p then 
            c=tonumber(p.Text) or W 
        end 
        
        local d=Instance.new("\70\114\97\109\101",T)
        d.Size=UDim2.new(0,90,0,40)
        d.Position=UDim2.new(0.5,60+(u*100),0.5,u*50)
        d.BackgroundColor3=Color3.new(0,0,0)
        d.Name=B.."_Mini"..u 
        Instance.new("\85\73\67\111\114\110\101\114",d)
        Instance.new("\85\73\83\116\114\111\107\101",d).Color=Color3.fromRGB(0,150,255)
        
        local e=Instance.new("\84\101\120\116\66\117\116\116\111\110",d)
        e.Size=UDim2.new(0,22,0,22)
        e.Position=UDim2.new(0,0,0,-25)
        e.Text="🔓"
        e.BackgroundColor3=Color3.fromRGB(0,150,255)
        Instance.new("\85\73\67\111\114\110\101\114",e)
        
        local f=Instance.new("\84\101\120\116\66\117\116\116\111\110",d)
        f.Size=UDim2.new(1,0,1,0)
        f.BackgroundTransparency=1 
        f.Text=B.."\n"..c 
        f.TextColor3=Color3.new(1,1,1)
        f.TextSize=10
        
        local g,t,m 
        local n=false 
        
        e.MouseButton1Click:Connect(function()
            n=not n 
            e.Text=n and "🔒" or "🔓"
            e.BackgroundColor3=n and Color3.fromRGB(200,50,50) or Color3.fromRGB(0,150,255)
        end)
        
        e.InputBegan:Connect(function(F)
            if not n and (F.UserInputType==Enum.UserInputType.MouseButton1 or F.UserInputType==Enum.UserInputType.Touch) then
                g=true 
                t=F.Position 
                m=d.Position 
            end
        end)
        
        S.InputChanged:Connect(function(F)
            if g and (F.UserInputType==Enum.UserInputType.MouseMovement or F.UserInputType==Enum.UserInputType.Touch) then
                local G=F.Position-t 
                d.Position=UDim2.new(m.X.Scale,m.X.Offset+G.X,m.Y.Scale,m.Y.Offset+G.Y)
            end
        end)
        
        S.InputEnded:Connect(function()
            g=false 
        end)
        
        f.MouseButton1Click:Connect(function()
            local o=_G.JK_Data[q].ActiveMini 
            
            if o and o.miniText==f then
                J(q,nil)
            else
                local s={
                    toggleText=b,
                    miniText=f,
                    value=c
                }
                table.insert(K[q],s)
                J(q,s)
            end
        end)
        
        u=u+1 
    end)
    
    b.MouseButton1Click:Connect(function()
        local c=W 
        if p then 
            c=tonumber(p.Text) or W 
        end 
        
        local o=_G.JK_Data[q].ActiveMini 
        
        if o and o.toggleText==b then
            J(q,nil)
        else
            local s={
                toggleText=b,
                miniText=nil,
                value=c
            }
            table.insert(K[q],s)
            J(q,s)
        end
    end)
    
    return D 
end

Y("\83\112\101\101\100",45,25,"\83\112\101\101\100")
Y("\74\117\109\112",85,50,"\74\117\109\112")
Y("\72\105\116",125,0.05,"\72\105\116")
Y("\69\83\80",165,0,"\69\83\80")

U.MouseButton1Click:Connect(function()
    P.Visible=false 
    local i=Instance.new("\84\101\120\116\66\117\116\116\111\110",T)
    i.Size=UDim2.new(0,80,0,30)
    i.Position=UDim2.new(0,10,0,10)
    i.Text="📂\32\74\75\32\80\118\80"
    i.BackgroundColor3=Color3.fromRGB(0,150,255)
    i.TextColor3=Color3.new(1,1,1)
    Instance.new("\85\73\67\111\114\110\101\114",i)
    
    i.MouseButton1Click:Connect(function()
        P.Visible=true 
        i:Destroy()
    end)
    
    local j,r,z 
    j=false,nil,nil 
    
    i.InputBegan:Connect(function(F)
        if F.UserInputType==Enum.UserInputType.MouseButton1 or F.UserInputType==Enum.UserInputType.Touch then
            j=true 
            r=F.Position 
            z=i.Position 
        end
    end)
    
    S.InputChanged:Connect(function(F)
        if j and (F.UserInputType==Enum.UserInputType.MouseMovement or F.UserInputType==Enum.UserInputType.Touch) then
            local G=F.Position-r 
            i.Position=UDim2.new(z.X.Scale,z.X.Offset+G.X,z.Y.Scale,z.Y.Offset+G.Y)
        end
    end)
    
    S.InputEnded:Connect(function()
        j=false 
    end)
end)

O.RenderStepped:Connect(function()
    local x=tick()%5/5 
    local l=Color3.fromHSV(x,1,1)

    for _,v in pairs(L:GetPlayers()) do
        if v~=X and v.Character and v.Character:FindFirstChild("\72\101\97\100") then
            local y=v.Character.Head 
            local k=y:FindFirstChild("\74\75\95\69\83\80")
            
            if _G.JK_Data.ESP.On then
                if not k then
                    k=Instance.new("\66\105\108\108\98\111\97\114\100\71\117\105",y)
                    k.Name="\74\75\95\69\83\80"
                    k.AlwaysOnTop=true 
                    k.Size=UDim2.new(0,80,0,40)
                    k.ExtentsOffset=Vector3.new(0,3,0)
                    
                    local _=Instance.new("\84\101\120\116\76\97\98\101\108",k)
                    _.Size=UDim2.new(1,0,1,0)
                    _.BackgroundTransparency=1 
                    _.Font="\71\111\116\104\97\109\66\111\108\100"
                    _.TextSize=10
                end
                
                local aa=v.Character:FindFirstChild("\72\117\109\97\110\111\105\100") and math.floor(v.Character.Humanoid.WalkSpeed) or 0
                k.TextLabel.Text=v.Name.."\n\86\58\32"..aa 
                k.TextLabel.TextColor3=l 
            elseif k then
                k:Destroy()
            end
        end
    end
end)

local ab=false 
local ac=false 

S.TextBoxFocused:Connect(function()
    ac=true 
end)

S.TextBoxFocusReleased:Connect(function()
    ac=false 
end)

task.spawn(function()
    while task.wait() do
        if _G.JK_Data.Hit.On and not ac and not ab then
            ab=true 
            C:SendMouseButtonEvent(0,0,0,true,game,0)
            task.wait(0.02)
            C:SendMouseButtonEvent(0,0,0,false,game,0)
            ab=false 
            
            local ad=_G.JK_Data.Hit.Val or 0.05
            task.wait(ad)
        else
            task.wait(0.1)
        end
    end
end)

O.Heartbeat:Connect(function()
    if X.Character and X.Character:FindFirstChild("\72\117\109\97\110\111\105\100\82\111\111\116\80\97\114\116") then
        local ae=X.Character.HumanoidRootPart 
        local af=X.Character:FindFirstChildOfClass("\72\117\109\97\110\111\105\100")
        
        if af then
            if _G.JK_Data.Speed.On and af.MoveDirection.Magnitude>0 then
                ae.Velocity=Vector3.new(
                    af.MoveDirection.X*_G.JK_Data.Speed.Val,
                    ae.Velocity.Y,
                    af.MoveDirection.Z*_G.JK_Data.Speed.Val
                )
            end
            
            if _G.JK_Data.Jump.On and S:IsKeyDown(Enum.KeyCode.Space) and af.FloorMaterial~=Enum.Material.Air then
                ae.Velocity=Vector3.new(ae.Velocity.X,_G.JK_Data.Jump.Val,ae.Velocity.Z)
            end
        end
    end
end)

print("\74\75\32\80\118\80\32\86\50\53\32\45\32\82\97\105\110\98\111\119\32\69\83\80\32\38\32\70\105\120\101\115\32\67\97\114\103\97\100\111\33")
print("\226\156\147\32\83\112\101\101\100\58\32\50\53\32\112\111\114\32\100\101\102\101\99\116\111")
print("\226\156\147\32\74\117\109\112\58\32\53\48")
print("\226\156\147\32\72\105\116\58\32\65\117\116\111\45\99\108\105\99\107\32\99\111\110\32\100\101\108\97\121\32\97\106\117\115\116\97\98\108\101")
print("\226\156\147\32\69\83\80\58\32\78\111\109\98\114\101\115\32\99\111\110\32\99\111\108\111\114\101\115\32\97\114\99\111\195\173\114\105\115")