From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 6 Feb 2013 19:24:08 -0200
Subject: [PATCH] ARM: mxs: Enable cpuidle
In-Reply-To: <20130203104113.GA26233@S2101-09.ap.freescale.net>
References: <1359733797-19538-1-git-send-email-festevam@gmail.com>
 <20130203104113.GA26233@S2101-09.ap.freescale.net>
Message-ID: <CAOMZO5DFcORto55LKZ1GEWjgMbpwL1Mgs=g7Zoi91CMi7LST_g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 3, 2013 at 8:41 AM, Shawn Guo <shawn.guo@linaro.org> wrote:

> I do not think suspend depends on CONFIG_CPU_IDLE to work.  Can you
> investigate the root cause why suspend does not work without enabling
> CONFIG_CPU_IDLE?

Ok, I managed to get suspend/resume working without turning on CONFIG_CPU_IDLE.

Will send the patch soon.
