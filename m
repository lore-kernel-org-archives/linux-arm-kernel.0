From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 20 Jul 2017 10:45:46 -0300
Subject: Debugging i.MX6QP HDMI Output on Mainline Kernel
In-Reply-To: <87d18z3yap.fsf@irata-debian.mntnas>
References: <87d18z3yap.fsf@irata-debian.mntnas>
Message-ID: <CAOMZO5AGiGyVBv++bWUv-Dt_fSa3jYs4g5FnT94KoQmHMW+__Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lukas,

On Mon, Jul 17, 2017 at 11:58 AM, Lukas F. Hartmann <lukas@mntmn.com> wrote:

> When starting a program that uses DRM, e.g. Xorg, the program will pause
> for 10 second intervals and DRM will log:

Could this be a X11 issue?

You can check Russell's X11 driver that works with Etnaviv:
http://git.arm.linux.org.uk/cgit/xf86-video-armada.git/
