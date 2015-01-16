From: dirk.behme@de.bosch.com (Dirk Behme)
Date: Fri, 16 Jan 2015 10:28:46 +0100
Subject: [PATCH 3/3] ARM: imx6: Fix procedure to switch the parent of
 LDB_DI_CLK
In-Reply-To: <CAOMZO5DB1QSg4G9mnWbS_ypQabFaJ8z-a4sR3Cj5cnq75atRKw@mail.gmail.com>
References: <1420559265-7333-1-git-send-email-p.zabel@pengutronix.de>
 <1420559265-7333-3-git-send-email-p.zabel@pengutronix.de>
 <20150108130003.GE4928@dragon>
 <CAOMZO5DB1QSg4G9mnWbS_ypQabFaJ8z-a4sR3Cj5cnq75atRKw@mail.gmail.com>
Message-ID: <54B8D9CE.40300@de.bosch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15.01.2015 17:54, Fabio Estevam wrote:
> Hi Shawn,
>
> On Thu, Jan 8, 2015 at 11:00 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
>
>> Before I start reviewing the patch, I would like to know if there is a
>> formal errata for this issue, including the bug description, recommended
>> workaround, and affected i.MX6 variants etc.
>
> The latest mx6 reference manual available on the web shows the LDB
> clock gate in the correct position now.
>
> It also adds the following note:
>
> "NOTE: This clock path is not controlled by a clock gate (CG). For
> proper clock switching procedures refer to the Clock Switching
> Multiplexers section."
>
> There is no formal errata available.
>
> Please consider reviewing this series, as it addresses a real problem
> that affect many users.


Just to get a better understanding for the background of this series: 
Are the patches in this series somehow related to Shawn's ENGR00318063-x 
patches in the FSL 3.10.53_1.1.0_ga kernel:

http://git.freescale.com/git/cgit.cgi/imx/linux-2.6-imx.git/log/?h=imx_3.10.53_1.1.0_ga&qt=grep&q=ENGR00318063

?

Or are this completely different topics?

Best regards

Dirk
