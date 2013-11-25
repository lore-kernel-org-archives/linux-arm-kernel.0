From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 25 Nov 2013 11:26:53 -0200
Subject: [PATCH] backlight: pwm_bl: Do not make the regulator mandatory
In-Reply-To: <20131125031029.GC11613@S2101-09.ap.freescale.net>
References: <20131122142231.GA1741@ulmo.nvidia.com>
 <20131122145224.GO14725@sirena.org.uk>
 <20131125031029.GC11613@S2101-09.ap.freescale.net>
Message-ID: <CAOMZO5CtNnma8Sv35P3jeNYQiLV=jdmN0Q7w2_LFMOj-nTbPZg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On Mon, Nov 25, 2013 at 1:10 AM, Shawn Guo <shawn.guo@linaro.org> wrote:

> Hmm, I'm seeing this breakage on v3.13-rc1 now with the following line
> in the kernel log.
>
>   pwm-backlight backlight.18: dummy supplies not allowed
>
> What's missing here?

Yes, this is weird.

linux-next 20131120: backlight fails
linux-next 20131122: backlight works
linux-next 20131125: backlight fails

Looks like we need to apply this one to make sure backlight works:
http://permalink.gmane.org/gmane.linux.ports.arm.kernel/281826

Regards,

Fabio Estevam
