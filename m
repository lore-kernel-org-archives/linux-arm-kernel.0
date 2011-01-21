From: johlstei@codeaurora.org (Jeff Ohlstein)
Date: Fri, 21 Jan 2011 14:29:16 -0800
Subject: [PATCH] ARM: smp: Fix Unknown IPI message 0x1
In-Reply-To: <20110117123409.GD20615@n2100.arm.linux.org.uk>
References: <1295265395-28485-1-git-send-email-santosh.shilimkar@ti.com>	<20110117120104.GB20615@n2100.arm.linux.org.uk>	<72ca984700f139fea98558783dde38f3@mail.gmail.com>	<20110117121951.GC20615@n2100.arm.linux.org.uk>	<1295267193.21557.14.camel@e102109-lin.cambridge.arm.com>	<d93218062aa1e6948453d1ddd5b9e2b0@mail.gmail.com>
	<20110117123409.GD20615@n2100.arm.linux.org.uk>
Message-ID: <4D3A08BC.8010303@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> On Mon, Jan 17, 2011 at 06:01:31PM +0530, Santosh Shilimkar wrote:
>   
>> Same for OMAP4. Any SGI will do.
>>     
>
> Ok, so we can convert OMAP, Realview, Versatile Express to use SGI0...
> that's a start!
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>   

SGI0 works fine for msm as well.

Jeff

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
