From: thomas.petazzoni@bootlin.com (Thomas Petazzoni)
Date: Wed, 12 Sep 2018 20:50:52 +0200
Subject: [BISECTED] Regression: Solidrun Clearfog Base won't boot since
 "PCI: mvebu: Only remap I/O space if configured"
In-Reply-To: <87zhwm4kl6.fsf@tkos.co.il>
References: <61fdfd69-2bb6-478c-b0d5-69d8744adae3@cesnet.cz>
 <87zhwm4kl6.fsf@tkos.co.il>
Message-ID: <20180912205052.19de01a0@windsurf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jan, Baruch,

On Wed, 12 Sep 2018 21:49:41 +0300, Baruch Siach wrote:

> Jan Kundr?t writes:
> > since commit ee1604381a371b3ea6aec7d5e43b6e3f5e153854 ("PCI: mvebu: Only
> > remap I/O space if configured"), my board (Solidrun Clearfog Base) won't
> > finish booting with 4.18-rc3 won't boot:  
> 
> You mean '4.19-rc3', right?
> 
> >> [    1.741458] Internal error: Oops - undefined instruction: 0 [#1] SMP ARM
> >> [    1.748182] CPU: 1 PID: 72 Comm: kworker/1:2 Tainted: G        W         4.19.0-rc3 #1  
> 
> The 'W' taint means that there was a kernel warning before. Which
> warning was that?
> 
> I reproduced the same Oops on Clearfog Base without any taint:

Thanks for the report, I'll have a look tomorrow when I have to
ClearFog hardware.

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
