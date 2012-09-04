From: jkrzyszt@tis.icnet.pl (Janusz Krzysztofik)
Date: Wed, 05 Sep 2012 00:37:30 +0200
Subject: [alsa-devel] [RFC update 0/2] dmaengine/ASoC: omap: Enable
 element mode in cyclic DMA
In-Reply-To: <1346760482-12794-1-git-send-email-peter.ujfalusi@ti.com>
References: <E1T8a09-0002vz-Bl@rmk-PC.arm.linux.org.uk>
 <1346760482-12794-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <11245085.Nc6xDQ9liJ@acer>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 4 Sep 2012 15:08:00 Peter Ujfalusi wrote:
> Hi Russell,
> 
> Enable the element mode (thus allowing mono playback and probably unblocking
> OMAP1, OMAP2420) in OMAP dmaengine and omap-pcm.
> 
> Janusz: would it be possible for you to test Russell's series plus this on
> OMAP1 to make sure that we do not broke it?

Hi Peter, Russell,
I'll be happy to make this test for you. This will take some time (I 
work away from home), but I expect to have it done by Monday.

BTW, I haven't been following OMAP development very closely last weeks, 
and I didn't even know about the OMAP DMA engine availability. Which 
Linux version should I base my test on? Would 3.6-rc be OK? Or l-o 
master?

Thanks,
Janusz
