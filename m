From: cavokz@gmail.com (Domenico Andreoli)
Date: Sun, 9 Sep 2012 02:30:27 +0200
Subject: [PATCH] ARM: add support for BCM2708/BCM2835 and Raspberry Pi
In-Reply-To: <20120908215609.GH13739@n2100.arm.linux.org.uk>
References: <1346908038-22421-1-git-send-email-swarren@wwwdotorg.org>
 <201209060904.14903.arnd@arndb.de> <20120906094703.GA7308@glitch>
 <201209061546.45242.arnd@arndb.de>
 <20120908215609.GH13739@n2100.arm.linux.org.uk>
Message-ID: <20120909003027.GB13519@glitch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 08, 2012 at 10:56:10PM +0100, Russell King - ARM Linux wrote:
> On Thu, Sep 06, 2012 at 03:46:44PM +0000, Arnd Bergmann wrote:
> > We just had a discussion about
> > stale platforms at the ARM mini summit in San Diego. IMHO if a port
> > gets started and then nobody works on filling the gaps for two
> > years, we should remove it again. 
> 
> One of the issues there is that you don't know if the reason it's not
> receiving patches or comments is because it works and people are using
> it, and they don't have anything to report against it.
> 
> That's certainly true of a number of platforms we currently have.

I would also like to know the usefulness/completeness requirements of
new platforms.

Expecting the latest designs in each area, what is wanted for a first
submission, besides the core stuff required for booting?

 - clocks
 - gpios
 - pinctrl
 - devicetree
 - uarts
 - dma
 - i2c
 - ...

For instance, I'm absolutely not interested in audio, displays and GPUs at
the moment, at least not those equipping this board. So I will not spend
any time to contribute anything of them. Would this be a stopper?

Regards,
Domenico
