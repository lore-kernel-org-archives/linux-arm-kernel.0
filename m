From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 8 Feb 2017 09:41:43 -0200
Subject: [PATCH] ARM: dts: imx53-qsb: Provide the TVE DAC regulators
In-Reply-To: <1486548734.2309.27.camel@pengutronix.de>
References: <1483470751-8073-1-git-send-email-festevam@gmail.com>
 <1486548734.2309.27.camel@pengutronix.de>
Message-ID: <CAOMZO5CB41R3T+C+NMApFfr8RfT1r3-8BggzwodFnXGLc7mxZg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 8, 2017 at 8:12 AM, Philipp Zabel <p.zabel@pengutronix.de> wrote:

> As Lucas pointed out, we could limit the board constraints to the
> necessary voltage here.
> Since this regulator is used as the TVDAC analog power supply, this
> range should at least be limited to the analog power supply range of the
> TVDAC, listed in Table 74-9. of the i.MX53 reference manual (2.5-2.75V).
>
> But since the nominal voltage is 2.75V, which was used to determine the
> analog gain that is supposed to result in the necessary 0.7V
> peak-to-peak amplitude on the VGA output, I'd say we should just fix the
> voltage to 2750000 here.

Yes, I will do as suggested. Thanks
