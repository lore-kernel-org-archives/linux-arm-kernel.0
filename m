From: b-cousson@ti.com (Cousson, Benoit)
Date: Thu, 15 Sep 2011 15:03:24 +0200
Subject: [PATCH 5/5] ARM: gic: add OF based initialization
In-Reply-To: <20110915125107.GK6267@n2100.arm.linux.org.uk>
References: <1316017900-19918-1-git-send-email-robherring2@gmail.com>
	<1316017900-19918-6-git-send-email-robherring2@gmail.com>
	<CAJuYYwSFu2HC+u2NY41+yw9tEyy85RKa4Dpm3SL+jbwS_OOA0A@mail.gmail.com>
	<4E71CE5D.9030900@ti.com>
	<20110915102915.GJ6267@n2100.arm.linux.org.uk>
	<4E71EF56.3050503@ti.com>
	<20110915125107.GK6267@n2100.arm.linux.org.uk>
Message-ID: <4E71F79C.6080900@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/15/2011 2:51 PM, Russell King - ARM Linux wrote:
> On Thu, Sep 15, 2011 at 02:28:06PM +0200, Cousson, Benoit wrote:
>> The HW specs is obviously counting the IRQ number at the GIC interface.
>> That offset is not known outside the MPUSS. Please have a look at the
>> OMAP4430 TRM p4761 (NDA vM version).
>
> As far as I know, I have no access to that.  I've certainly never been
> pointed to any documentation on OMAP4.

That's easy to fix since the same information is in the public TRM 
(p3386 in that case). And here is the link:
http://focus.ti.com/pdfs/wtbu/OMAP4430_ES2.x_PUBLIC_TRM_vX.zip

Do not hesitate to ask if you never further information on OMAP SoC.

Regards,
Benoit
