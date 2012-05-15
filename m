From: will.deacon@arm.com (Will Deacon)
Date: Tue, 15 May 2012 14:52:28 +0100
Subject: oprofile and ARM A9 hardware counter
In-Reply-To: <4FADA5E4.80006@ti.com>
References: <20120510084422.GB27276@mudshark.cambridge.arm.com>
 <4FAC0F05.3060803@ti.com>
 <20120511122547.GE17453@mudshark.cambridge.arm.com>
 <4FAD1865.70003@ti.com>
 <20120511134920.GC2626@mudshark.cambridge.arm.com>
 <4FAD27CB.5060102@ti.com>
 <20120511150223.GD2626@mudshark.cambridge.arm.com>
 <4FAD3EF3.4080409@ti.com>
 <20120511163831.GI2626@mudshark.cambridge.arm.com>
 <4FADA5E4.80006@ti.com>
Message-ID: <20120515135228.GD10057@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 12, 2012 at 12:51:00AM +0100, Jon Hunter wrote:
> On 05/11/2012 11:38 AM, Will Deacon wrote:
> > Excellent, that works for me. Once we've worked out the problem with my
> > .config you can have my tested-by.
> 
> Great! I have been looking at your .config, but I have not been able to
> figure out the problem so far. Do you recall what your config is based
> upon? I seems quite different to mine and the omap2plus_defconfig has
> not changed much in the last few kernel releases.

Hmm, I'm honestly not sure -- it was just lying around in my home directory.
Given that I know very little about OMAP, I would suspect that it's either
based on the defconfig or I inherited a working kernel image from somebody
else and used /proc/config.gz to build my own.

Will
