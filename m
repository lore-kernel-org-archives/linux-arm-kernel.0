From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 20 Jul 2017 14:50:21 +0100
Subject: Debugging i.MX6QP HDMI Output on Mainline Kernel
In-Reply-To: <CAOMZO5AGiGyVBv++bWUv-Dt_fSa3jYs4g5FnT94KoQmHMW+__Q@mail.gmail.com>
References: <87d18z3yap.fsf@irata-debian.mntnas>
 <CAOMZO5AGiGyVBv++bWUv-Dt_fSa3jYs4g5FnT94KoQmHMW+__Q@mail.gmail.com>
Message-ID: <20170720135021.GA31807@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 20, 2017 at 10:45:46AM -0300, Fabio Estevam wrote:
> Hi Lukas,
> 
> On Mon, Jul 17, 2017 at 11:58 AM, Lukas F. Hartmann <lukas@mntmn.com> wrote:
> 
> > When starting a program that uses DRM, e.g. Xorg, the program will pause
> > for 10 second intervals and DRM will log:
> 
> Could this be a X11 issue?
> 
> You can check Russell's X11 driver that works with Etnaviv:
> http://git.arm.linux.org.uk/cgit/xf86-video-armada.git/

I know Dan MacDonald was reporting the same issue, and he was using my
driver.  We never got to the bottom of Dan's issue though, and I tried
suggesting disabling the other outputs.

Lukas' dt files only have HDMI output, so much like the SR Hummingboard
setup - but that seems to work fine (although I don't have any iMX6QP
devices, only iMX6S, D, Q and possibly a DL.)

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
