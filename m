From: john@phrozen.org (John Crispin)
Date: Mon, 11 Jul 2016 20:55:24 +0200
Subject: [PATCH V8 1/2] regulator: Add document for MT6323 regulator
In-Reply-To: <20160711180805.GG3701@sirena.org.uk>
References: <1468240179-7558-1-git-send-email-john@phrozen.org>
 <20160711180805.GG3701@sirena.org.uk>
Message-ID: <cef78bd8-9a4a-e848-d7cb-13a27127f11e@phrozen.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 11/07/2016 20:08, Mark Brown wrote:
> On Mon, Jul 11, 2016 at 02:29:38PM +0200, John Crispin wrote:
> 
>> This is a resend as V7 was dropped due to a merge order conflict.
> 
> What were the dependencies and why will simply resending this resolve
> them?
> 

Hi Mark,

the dependency was the mt6323 support inside the mt6397 MFD device [1]
and the headers that it included. this has been merged so the regulator
driver is good to go for 4.8

	John

[1]
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/mfd/mt6397-core.c?id=refs/tags/v4.7-rc7

> 
> 
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
> 
