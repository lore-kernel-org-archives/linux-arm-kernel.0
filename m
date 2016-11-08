From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 8 Nov 2016 15:42:49 +0000
Subject: [PATCH RFC 00/12] tda998x updates
In-Reply-To: <624786c1-0d55-8ab6-2db0-0497248201ca@arm.com>
References: <20161108122420.GP1041@n2100.armlinux.org.uk>
 <2264579a-3273-d9c4-761a-f50f547eb39b@arm.com>
 <20161108133215.GQ1041@n2100.armlinux.org.uk>
 <20161108133411.GA31754@n2100.armlinux.org.uk>
 <624786c1-0d55-8ab6-2db0-0497248201ca@arm.com>
Message-ID: <20161108154249.GT1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 08, 2016 at 03:25:45PM +0000, Robin Murphy wrote:
> On 08/11/16 13:34, Russell King - ARM Linux wrote:
> > On Tue, Nov 08, 2016 at 01:32:15PM +0000, Russell King - ARM Linux wrote:
> >> Unfortunately, my drm-tda998x-devel branch is slightly out of date with
> >> these patches it's the original set of 10 patches.  I've not pushed
> >> these ones out to that branch yet, as I've three additional patches on
> >> top of these which aren't "ready" for pushing out.
> > 
> > Here's the delta between the branch and what I just posted:
> 
> Great, thanks. I committed that on top and my framebuffer console over
> DVI is still working. I'm dubious that it's thorough enough to have
> value (sadly I have neither the time nor the motivation to fight with
> HDMI and I2S audio), but feel free to consider that a tested-by if you
> wish.

Well, "nothing obviously broken" is good enough, thanks.

I don't have (or use) I2S video on my TDA998x, and that's something
which is in Jyri's interest area.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
