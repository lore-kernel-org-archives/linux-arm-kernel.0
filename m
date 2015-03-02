From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 2 Mar 2015 15:19:40 +0100
Subject: [alsa-devel] [PATCH] ASoC: sam9g20_wm8731: drop machine_is_xxx
In-Reply-To: <20150302140638.GW21293@sirena.org.uk>
References: <1420542872-10015-1-git-send-email-alexandre.belloni@free-electrons.com>
 <20150106174521.GM2634@sirena.org.uk>
 <20150302134253.GQ4094@piout.net>
 <20150302140638.GW21293@sirena.org.uk>
Message-ID: <20150302141940.GR4094@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/03/2015 at 14:06:38 +0000, Mark Brown wrote :
> On Mon, Mar 02, 2015 at 02:42:53PM +0100, Alexandre Belloni wrote:
> > On 06/01/2015 at 17:45:21 +0000, Mark Brown wrote :
> > > On Tue, Jan 06, 2015 at 12:14:32PM +0100, Alexandre Belloni wrote:
> 
> > > > Atmel based boards can now only be used with device tree. Drop non DT
> > > > initialization.
> 
> > > Applied, thanks.
> 
> > I don't see that patch in 4.0-rc1. This will lead to a compilation error
> > as all the machine_is_at91xxx have been removed.
> 
> *sigh*  If something is a bug fix then please flag it as such; nothing
> in your message gives any hint that this is a fix rather than just a
> random cleanup.

Well, I though this would be applied along with
"ASoC: atmel: sam9g20_wm8731: remove useless include" which made it to
4.0-rc1 and was also a simple cleanup.

It was a simple cleanup until all the machine_is_at91xxx got dropped :)

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
