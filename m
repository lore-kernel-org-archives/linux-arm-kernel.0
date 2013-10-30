From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 29 Oct 2013 23:00:01 -0200
Subject: [PATCH v3] imx-drm: Add mx6 hdmi transmitter support
In-Reply-To: <20131029234726.GV16735@n2100.arm.linux.org.uk>
References: <1382992009-19407-1-git-send-email-festevam@gmail.com>
 <20131028210346.GA11985@kroah.com>
 <CAOMZO5AX+uh0sT7FHJZBP_ufKznkuFn7jNCB__vrwpcMrqY36w@mail.gmail.com>
 <20131029234726.GV16735@n2100.arm.linux.org.uk>
Message-ID: <CAOMZO5DoQ4BwV7TDpQ1aSgs_bdJbn4ApjsVQGqDE5-VOmVtViw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 29, 2013 at 9:47 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:

> The issues surrounding DT and DRM were given an airing last week at
> kernel summit in a session chaired by David Airlie.
>
> The Kernel Summit session was to discuss issues surrounding DT and DRM,
> or more specifically DT and componentised subsystems like DRM, ASoC and
> V4L2.  Grant Likely has said that he will attempt to summarise some of
> the discussion there; unfortunately I'm not aware of anyone making any
> real "minutes" of what was discussed - it wasn't a formal session.
>
> I also had discussions with David Airlie and, separately, with the
> Pengutronix folk about imx-drm.
>
> It is very clear to me that David is against imx-drm moving into
> drivers/gpu/drm - the driver requires an amount of rework in various
> places.  So I don't think it will move out of drivers/staging any
> time soon.
>
> I have a few other bits to sort out first, but I've volunteered to try
> to resolve some of these blocking issues so that imx-drm can move
> forward and hopefully out of staging.
>
> To put it another way, moving this driver out of staging is not as
> simple as moving the files; it requires real work to address the
> issues the subsystem maintainer has with this code.

Thanks for your detailed explanation, Russell.
