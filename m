From: leonard.crestez@nxp.com (Leonard Crestez)
Date: Wed, 21 Jun 2017 13:53:04 +0300
Subject: [PATCH] cpufreq: imx6q: imx6ull should use the same flow as imx6ul
In-Reply-To: <CAOMZO5A+suW4gS0_7U+g=abvXfFp-bXs5wE1jNPZWwy7HUgSwA@mail.gmail.com>
References: <30688f5aa17763362275c199b2d61841497c26a4.1496159470.git.leonard.crestez@nxp.com>
 <CAOMZO5A+suW4gS0_7U+g=abvXfFp-bXs5wE1jNPZWwy7HUgSwA@mail.gmail.com>
Message-ID: <1498042384.32344.1.camel@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2017-05-31 at 01:07 -0300, Fabio Estevam wrote:
> On Tue, May 30, 2017 at 12:57 PM, Leonard Crestez
> <leonard.crestez@nxp.com> wrote:
> > 
> > From: Octavian Purdila <octavian.purdila@nxp.com>
> > 
> > This fixes an issue with imx6ull where setting the frequency to
> > 528Mhz
> > would actually set the ARM clock to 324Mhz.
> > 
> > Signed-off-by: Octavian Purdila <octavian.purdila@nxp.com>
> > Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>

This is a gentle reminder that this patch has been posted 3 weeks ago
but has not yet been applied.

--
Regards,
Leonard
