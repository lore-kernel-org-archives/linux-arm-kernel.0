From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 16 Feb 2017 11:42:29 +0100
Subject: sDMA on i.mx7d
In-Reply-To: <3513b2c01d86ad7312522d6be97e766f@agner.ch>
References: <20170214222425.hbkfkeq3l6sveo7n@piout.net>
 <e9c36a33f2a49df2a517db5869eaea7f@agner.ch>
 <20170215110736.oumvvv7zordd2jdw@piout.net>
 <3513b2c01d86ad7312522d6be97e766f@agner.ch>
Message-ID: <20170216104229.axwm3445yj6zrxoz@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/02/2017 at 14:44:12 -0800, Stefan Agner wrote:
> Compiled v4.9 and played a song, I could clearly hear constant "noise"
> during playback.
> 
> I went back to my v4.8-rc3 + some patches applied back when I tested
> audio and submitted the device tree change, and the noise isn't there.
> 
> In a "I feel lucky" manor I just reverted the last patch 5881826ded79
> ("dmaengine: imx-sdma - update the residue calculation for cyclic
> channels") and the song sounded clean as always again!
> 
> Alexandre, does reverting this helps your issue too?
> 

I confirm it is the culprit.

> +Nandor, Author of said patch. Any idea?
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
