From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 6 Oct 2015 17:25:16 -0300
Subject: [PATCH 1/9] drm: bridge/dw_hdmi-ahb-audio: add audio driver
In-Reply-To: <20151006185429.GU21513@n2100.arm.linux.org.uk>
References: <20150808160936.GN7557@n2100.arm.linux.org.uk>
 <E1ZO6hC-0003M5-EU@rmk-PC.arm.linux.org.uk>
 <CAOMZO5COgoGU-3YNpnmSkctHMRDJ3=DuKc82Wb5zTTX7Bx2jNw@mail.gmail.com>
 <20151006181806.GS21513@n2100.arm.linux.org.uk>
 <CAOMZO5DaowTGQqN_NW7T2zv-P6a_YZUCumq4-m+OtpsKqFzELw@mail.gmail.com>
 <20151006185429.GU21513@n2100.arm.linux.org.uk>
Message-ID: <CAOMZO5C8O0p6C0hrAvHzanru9W2f8-C7MWsm3+HumoyZ9Hu6Jw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 6, 2015 at 3:54 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:

> Make sure you have the ALSA config file, as alsalib won't get on
> with dw-hdmi only accepting 24-bit audio without this.  A copy is
> attached.  It also tells ALSA how to deal with multi-channel audio
> as well.

Thanks, Russell!

Got audio to play on my HDMI TV :-)

For the entire series:

Tested-by: Fabio Estevam <fabio.estevam@freescale.com>
