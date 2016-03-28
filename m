From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 28 Mar 2016 15:48:59 -0300
Subject: [PATCH v4 3/3] ARM: imx6: Fix procedure to switch the parent of
 LDB_DI_CLK
In-Reply-To: <56D60C90.7080703@timesys.com>
References: <1456476714-11351-1-git-send-email-p.zabel@pengutronix.de>
 <1456476714-11351-4-git-send-email-p.zabel@pengutronix.de>
 <56D60C90.7080703@timesys.com>
Message-ID: <CAOMZO5A6HoQ0i7rMm4Ov6AZP6DrE+Vh09NgLtVm0yfDHH62XKw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Akshay,

On Tue, Mar 1, 2016 at 6:41 PM, Akshay Bhat <akshay.bhat@timesys.com> wrote:

> EB821 doesn't mention the above restriction. My understanding was as long as
> the clock source you are switching from/to is disabled it should be ok to do
> so. Maybe someone from Freescale can comment?

I don't have access to this EB821 document.

The procedure we have tested is shown here:
http://git.freescale.com/git/cgit.cgi/imx/linux-2.6-imx.git/commit/?h=imx_3.10.17_1.0.1_ga&id=eecbe9a52587cf9eec30132fb9b8a6761f3a1e6d
