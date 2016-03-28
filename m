From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 28 Mar 2016 15:53:44 -0300
Subject: [PATCH v4 3/3] ARM: imx6: Fix procedure to switch the parent of
 LDB_DI_CLK
In-Reply-To: <CACrMeVAtLMdx6FhhmvxOq=_q=HztU_2nqVwzbL3dYBHd-PWKUg@mail.gmail.com>
References: <1456476714-11351-1-git-send-email-p.zabel@pengutronix.de>
 <1456476714-11351-4-git-send-email-p.zabel@pengutronix.de>
 <56D60C90.7080703@timesys.com>
 <CACrMeVAtLMdx6FhhmvxOq=_q=HztU_2nqVwzbL3dYBHd-PWKUg@mail.gmail.com>
Message-ID: <CAOMZO5DJ=2xo3ciDDoC1KVwHpxagEjNHq5hEkS7StBzaXrk-pQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Akshay,

On Wed, Mar 23, 2016 at 12:48 PM, Akshay Bhat <akshay.bhat@timesys.com> wrote:

> Any comment from NXP regarding the same? I have tested this patch as
> it is and it resolves intermittent blank LVDS display issues we are
> seeing on our boards. The questions is if the patch needs to be
> updated to match EB821 document for the above sections?

I am not aware of such document.

Do you see any discrepancy with regards to the sequence from NXP 3.10 kernel?
http://git.freescale.com/git/cgit.cgi/imx/linux-2.6-imx.git/commit/?h=imx_3.10.17_1.0.1_ga&id=eecbe9a52587cf9eec30132fb9b8a6761f3a1e6d

>
> It would be nice to get the patch accepted since it solves actual LVDS
> display issues on clock switch.

Yes, agreed.

Thanks for testing the patch.
