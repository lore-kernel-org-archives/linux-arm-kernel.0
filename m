From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 21 Jul 2015 16:55:39 +0100
Subject: [PATCH 4/5] regulator: 88pm800: Add 88pm860 regulator support
In-Reply-To: <55AE62F2.4050403@linaro.org>
References: <20150716213429.GE1602@sirena.org.uk> <55A895AC.8070101@linaro.org>
 <20150717111733.GL11162@sirena.org.uk>
 <55A8F859.2090204@linaro.org> <20150720073011.GA3061@x1>
 <55ACE2FC.2090801@linaro.org> <20150721092148.GI3061@x1>
 <55AE29DF.10102@linaro.org> <20150721151314.GM3061@x1>
 <55AE62F2.4050403@linaro.org>
Message-ID: <20150721155539.GO3061@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >>>>I have just sent single patch, which has dependency on regulator
> >>>>changes. Please review, ack and queue up.
> >>>
> >>>A little presumptuous, don't you think? ;)
> >>>
> >>>>[PATCH-v3] mfd: 88pm80x: Add 88pm860 chip type support
> >>>>https://patchwork.kernel.org/patch/6826531/
> >>>
> >>>So nothing depends on this anymore, right?
> >>>
> >>
> >>No, regulato patch depends on this.
> >>Mark needs your tag in order to take above patch through regulator tree.
> >
> >That's not how we usually do things.
> >
> >However, as this patch is a very simple one, it shouldn't cause too
> >many issues if it were to go in via the Regulator tree.
> >
> 
> Thanks for your ack.
> 
> And I understand your concern, but not sure how would you solve such
> dependency?

We usually share immutable branches, which contain all of the patches
in the correct order.

> Another point which keeps bugging me is, git-bisect.

... which also mitigates bisect issues.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
