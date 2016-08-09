From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 9 Aug 2016 10:29:20 -0300
Subject: [PATCH 1/1] ARM: mach-imx: pm-imx6: add missing
 BM_CLPCR_BYP_MMDC_CH0_LPM_HS setting for imx6ul
In-Reply-To: <1470731083-26213-1-git-send-email-peter.chen@nxp.com>
References: <1470731083-26213-1-git-send-email-peter.chen@nxp.com>
Message-ID: <CAOMZO5AEHQjzP7=pTK3b2J+BSzcdXm=7aPNuv_sf0_8j8EAyJg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

On Tue, Aug 9, 2016 at 5:24 AM, Peter Chen <peter.chen@nxp.com> wrote:
> There is a missing BM_CLPCR_BYP_MMDC_CH0_LPM_HS setting for imx6ul,
> without it, the "standby" mode can't work well, the system can't be
> resumed.
>
> With this commit, the "standby" mode works well.

Have you tested 'echo mem > /sys/power/state' as well?

On my tests it does a reboot rather than going to suspend.

Thanks
