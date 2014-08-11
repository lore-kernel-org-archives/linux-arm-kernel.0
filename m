From: grant.b.edwards@gmail.com (Grant Edwards)
Date: Mon, 11 Aug 2014 15:47:29 +0000 (UTC)
Subject: Building kernel for more than one SoC
References: <lrdi48$ls1$1@ger.gmane.org>
 <20140804201712.GK30282@n2100.arm.linux.org.uk>
 <53E8E469.9050807@atmel.com>
Message-ID: <lsaoih$e9$1@ger.gmane.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014-08-11, Nicolas Ferre <nicolas.ferre@atmel.com> wrote:
> On 04/08/2014 22:17, Russell King - ARM Linux :

[...]

>> Even better is to abstract the differences and have the same driver
>> code deal with the different variants internally - the selection of
>> which variant being controlled via the device tree "compatible"
>> property, or another appropriate method.
>
> Sure. Everything in at91 is converted to device tree those days.

That's good to hear, thanks.

Now it's up to somebody else to decide if the price difference between
a G20 and G25 is worth the engineering time to upgrade U-Boot and
Linux kernel to versions that know about device trees...

-- 
Grant Edwards               grant.b.edwards        Yow! I smell a RANCID
                                  at               CORN DOG!
                              gmail.com            
