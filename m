From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 15 Jan 2015 14:54:24 -0200
Subject: [PATCH 3/3] ARM: imx6: Fix procedure to switch the parent of
 LDB_DI_CLK
In-Reply-To: <20150108130003.GE4928@dragon>
References: <1420559265-7333-1-git-send-email-p.zabel@pengutronix.de>
 <1420559265-7333-3-git-send-email-p.zabel@pengutronix.de>
 <20150108130003.GE4928@dragon>
Message-ID: <CAOMZO5DB1QSg4G9mnWbS_ypQabFaJ8z-a4sR3Cj5cnq75atRKw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On Thu, Jan 8, 2015 at 11:00 AM, Shawn Guo <shawn.guo@linaro.org> wrote:

> Before I start reviewing the patch, I would like to know if there is a
> formal errata for this issue, including the bug description, recommended
> workaround, and affected i.MX6 variants etc.

The latest mx6 reference manual available on the web shows the LDB
clock gate in the correct position now.

It also adds the following note:

"NOTE: This clock path is not controlled by a clock gate (CG). For
proper clock switching procedures refer to the Clock Switching
Multiplexers section."

There is no formal errata available.

Please consider reviewing this series, as it addresses a real problem
that affect many users.

Thanks,

Fabio Estevam
