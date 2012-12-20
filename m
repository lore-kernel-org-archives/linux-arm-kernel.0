From: vaibhav.bedia@ti.com (Bedia, Vaibhav)
Date: Thu, 20 Dec 2012 06:44:46 +0000
Subject: BUG: spinlock bad magic on CPU#0 on BeagleBone
In-Reply-To: <50D2AF54.7050402@codeaurora.org>
References: <B5906170F1614E41A8A28DE3B8D121433EC9A69C@DBDE01.ent.ti.com>
 <alpine.DEB.2.00.1212191650430.16873@utopia.booyaka.com>
 <50D2224E.4060300@codeaurora.org>
 <B5906170F1614E41A8A28DE3B8D121433EC9B6FE@DBDE01.ent.ti.com>
 <50D2AF54.7050402@codeaurora.org>
Message-ID: <B5906170F1614E41A8A28DE3B8D121433EC9B964@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 20, 2012 at 11:55:24, Stephen Boyd wrote:
> On 12/19/2012 8:48 PM, Bedia, Vaibhav wrote:
> > I tried out 3 variants of AM335x boards - 2 of these (BeagleBone and EVM) have DDR2
> > and 1 has DDR3 (EVM-SK). The BUG is triggered on all of these at the same point.
> >
> > With Stephen's change I don't see this on any of the board variants :)
> > New bootlog below.
> 
> Great! Can I have your Tested-by then? I'll wrap it up into a patch. Is
> this is a new regression? From a glance at the code it looks to have
> existed for quite a while now.

I went back to a branch based off 3.7-rc4 and don't see the issue there. Not sure
what is triggering this now.

Tested-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
