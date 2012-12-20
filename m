From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 19 Dec 2012 22:25:24 -0800
Subject: BUG: spinlock bad magic on CPU#0 on BeagleBone
In-Reply-To: <B5906170F1614E41A8A28DE3B8D121433EC9B6FE@DBDE01.ent.ti.com>
References: <B5906170F1614E41A8A28DE3B8D121433EC9A69C@DBDE01.ent.ti.com>
 <alpine.DEB.2.00.1212191650430.16873@utopia.booyaka.com>
 <50D2224E.4060300@codeaurora.org>
 <B5906170F1614E41A8A28DE3B8D121433EC9B6FE@DBDE01.ent.ti.com>
Message-ID: <50D2AF54.7050402@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/19/2012 8:48 PM, Bedia, Vaibhav wrote:
> I tried out 3 variants of AM335x boards - 2 of these (BeagleBone and EVM) have DDR2
> and 1 has DDR3 (EVM-SK). The BUG is triggered on all of these at the same point.
>
> With Stephen's change I don't see this on any of the board variants :)
> New bootlog below.

Great! Can I have your Tested-by then? I'll wrap it up into a patch. Is
this is a new regression? From a glance at the code it looks to have
existed for quite a while now.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
