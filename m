From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 9 Dec 2011 07:16:24 -0200
Subject: [PATCH] arm/imx: fix cpufreq build error
In-Reply-To: <1323399055-31850-1-git-send-email-shawn.guo@linaro.org>
References: <20111209020948.GA28216@b20223-02.ap.freescale.net>
 <1323399055-31850-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <CAOMZO5DemwevSw0=B4+wrDSR4tfmnPDAkY7cHwKiuHnq9pu5pg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 9, 2011 at 12:50 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> This patch adds missing linux/module.h to fix the build error seen
> on imx cpuidle driver.

It would be nice to add which was the commit that introduced this build error.

Regards,

Fabio Estevam
