From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Fri, 12 Jul 2013 11:09:51 +0200
Subject: [PATCH 1/6] ARM: OMAP2+: Remove board-4430sdp.c
In-Reply-To: <20130709082304.GB5523@atomide.com>
References: <20130517191304.468.73487.stgit@localhost>
 <20130517191751.468.89202.stgit@localhost>
 <20130520095447.GR21614@n2100.arm.linux.org.uk>
 <20130706131057.GU21614@n2100.arm.linux.org.uk>
 <20130706133627.GV21614@n2100.arm.linux.org.uk>
 <20130708093410.GT5523@atomide.com>
 <20130708142103.GX21614@n2100.arm.linux.org.uk>
 <20130709082304.GB5523@atomide.com>
Message-ID: <51DFC7DF.7050806@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/09/2013 10:23 AM, Tony Lindgren wrote:
>> ASoC looks dead too:
>>
>> omap-abe-twl6040 sound.10: ASoC: CPU DAI (null) not registered
>> omap-abe-twl6040 sound.10: snd_soc_register_card() failed: -517
> 
> Peter, I think you've had audio working with devicetree for at least
> a year or something?

Yes it has been working and going to work soon again:
http://mailman.alsa-project.org/pipermail/alsa-devel/2013-July/063909.html

With the DMA devicetree bindings platform_get_resource_byname() stopped
working for DMA (it works for MEM resources) -> dai drivers were not probing.

-- 
P?ter
