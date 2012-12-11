From: pratikp@codeaurora.org (Pratik Patel)
Date: Tue, 11 Dec 2012 13:39:16 -0800
Subject: Coresight bus and drivers from CodeAurora
In-Reply-To: <CACRpkdYeFw3YqYqgNAKUv1U4edyzzUa9x6xBSoBU4BbBoc6q5Q@mail.gmail.com>
References: <CACRpkdYeFw3YqYqgNAKUv1U4edyzzUa9x6xBSoBU4BbBoc6q5Q@mail.gmail.com>
Message-ID: <20121211213916.GB7214@pratikp-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus

On Mon, Dec 10, 2012 at 01:40:20PM +0100, Linus Walleij wrote:
> Hi Pratik,
> 
> recently my colleague Magnus (@ST-Ericsson) found this bus and
> implementations for the ARM Coresight and drivers for the ARM Coresight
> blocks ETB, ETM, Funnel, Replicator, STM, TMC and TPIU. The
> code is here:
> https://www.codeaurora.org/gitweb/quic/le/?p=kernel/msm.git;a=tree;f=drivers/coresight;h=f0221ea9a55c1e8bcd63f36ec28abb6d5406e63d;hb=refs/heads/msm-3.4
> 
> What is your intention with this? Do you have any intention to mainline?
> 

Thanks for the quick evaluation. I will be working on cleaning up
the drivers for upstream submission in the coming weeks.

> We can see it has references to Qualcomm in the device tree strings even
> though they are ARM Coresight HW blocks, for example, so some changes
> are likely necessary, and such bindings should pass the devicetree-discuss
> list.
> 

Yes, will clean it up.

> Will: what is ARM Ltd. position on these blocks and their drivers? Any plans
> from your side?
> 
> Douglas: look another STM driver... :-)
> 
> John Stultz has recently been working on some PTM extensions
> submitted by Arve Hj?nnev?g as well, relating quite closely to this.
> 
> The design is nice, but maybe this is one of the few cases where the
> drivers should actually live under arch/arm/common/* or similar.
> 
> Yours,
> Linus Walleij
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
