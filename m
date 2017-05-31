From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 31 May 2017 01:07:17 -0300
Subject: [PATCH] cpufreq: imx6q: imx6ull should use the same flow as imx6ul
In-Reply-To: <30688f5aa17763362275c199b2d61841497c26a4.1496159470.git.leonard.crestez@nxp.com>
References: <30688f5aa17763362275c199b2d61841497c26a4.1496159470.git.leonard.crestez@nxp.com>
Message-ID: <CAOMZO5A+suW4gS0_7U+g=abvXfFp-bXs5wE1jNPZWwy7HUgSwA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 30, 2017 at 12:57 PM, Leonard Crestez
<leonard.crestez@nxp.com> wrote:
> From: Octavian Purdila <octavian.purdila@nxp.com>
>
> This fixes an issue with imx6ull where setting the frequency to 528Mhz
> would actually set the ARM clock to 324Mhz.
>
> Signed-off-by: Octavian Purdila <octavian.purdila@nxp.com>
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
