From: cjb@laptop.org (Chris Ball)
Date: Tue, 04 Dec 2012 11:06:39 -0500
Subject: [PATCH 3/3] MMC: sdhci-dove: allow GPIOs to be used for card
 detection on Dove
In-Reply-To: <Pine.LNX.4.64.1212041651500.26918@axis700.grange> (Guennadi
 Liakhovetski's message of "Tue, 4 Dec 2012 17:00:49 +0100 (CET)")
References: <20121122235426.GT3332@n2100.arm.linux.org.uk>
 <E1TbgcZ-0007Kt-35@rmk-PC.arm.linux.org.uk>
 <20121123083117.GA25754@S2100-06.ap.freescale.net>
 <20121123085726.GK5764@n2100.arm.linux.org.uk>
 <20121123121422.GA26168@S2100-06.ap.freescale.net>
 <20121123125507.GO5764@n2100.arm.linux.org.uk>
 <871ufh8lza.fsf@octavius.laptop.org>
 <Pine.LNX.4.64.1211260955070.11501@axis700.grange>
 <87y5hfhrwg.fsf@octavius.laptop.org>
 <Pine.LNX.4.64.1212041651500.26918@axis700.grange>
Message-ID: <87zk1tg5tc.fsf@octavius.laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Guennadi,

On Tue, Dec 04 2012, Guennadi Liakhovetski wrote:
>> They both sound pretty attractive.  Maybe we start out with (1), which
>> would create a patch we could more reasonably send to stable@ to get
>> slot-gpio handling the reset during transfers properly in older kernels,
>> and then refactor into (2) later?
>
> Just posted 3 patches for this, have a look if that's what you were 
> thinking about. Not sure though why this is needed for stable, but I'm 
> probably just missing some crucial information on the topic.

Thanks!  I'll take a look.  I agree that this isn't definitely needed
in -stable, but I'm glad we have the option if someone finds that their
host isn't functioning after card removal during a transfer.

Russell, are you happy with switching sdhci-dove over to slot-gpio with
this patchset?

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
