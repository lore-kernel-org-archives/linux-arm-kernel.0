From: jon-hunter@ti.com (Jon Hunter)
Date: Fri, 11 May 2012 18:51:00 -0500
Subject: oprofile and ARM A9 hardware counter
In-Reply-To: <20120511163831.GI2626@mudshark.cambridge.arm.com>
References: <4FAAC549.6010206@ti.com> <4FAAE564.6040708@ti.com>
 <20120510084422.GB27276@mudshark.cambridge.arm.com> <4FAC0F05.3060803@ti.com>
 <20120511122547.GE17453@mudshark.cambridge.arm.com> <4FAD1865.70003@ti.com>
 <20120511134920.GC2626@mudshark.cambridge.arm.com> <4FAD27CB.5060102@ti.com>
 <20120511150223.GD2626@mudshark.cambridge.arm.com> <4FAD3EF3.4080409@ti.com>
 <20120511163831.GI2626@mudshark.cambridge.arm.com>
Message-ID: <4FADA5E4.80006@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On 05/11/2012 11:38 AM, Will Deacon wrote:
> On Fri, May 11, 2012 at 05:31:47PM +0100, Jon Hunter wrote:
>> Can you send me your .config?
> 
> Sent off-list.
> 
>> At the same time, maybe just try "make omap2plus_defconfig" and enable
>> the OMAP3 debug devices config. That's all I am doing.
> 
> Excellent, that works for me. Once we've worked out the problem with my
> .config you can have my tested-by.

Great! I have been looking at your .config, but I have not been able to
figure out the problem so far. Do you recall what your config is based
upon? I seems quite different to mine and the omap2plus_defconfig has
not changed much in the last few kernel releases.

Cheers
Jon
