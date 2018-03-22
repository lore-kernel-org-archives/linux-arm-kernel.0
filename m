From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 22 Mar 2018 11:14:57 -0300
Subject: [PATCH 1/4] arm: imx: Update clk driver API
In-Reply-To: <1521712529-632-2-git-send-email-abel.vesa@nxp.com>
References: <1521712529-632-1-git-send-email-abel.vesa@nxp.com>
 <1521712529-632-2-git-send-email-abel.vesa@nxp.com>
Message-ID: <CAOMZO5CkwK1yoJKEx4UOB1sp0y95SZrkRmyojXWxROLKJAdWow@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 22, 2018 at 6:55 AM, Abel Vesa <abel.vesa@nxp.com> wrote:
> This adds the following new wrappers:
>  - imx_clk_gate2_flag
>  - imx_clk_set_parent

Please explain the motivation for adding these two new functions in
the commit log.

>
> It also updates the flags for the old wrappers.
>
> Signed-off-by: Anson Huang <anson.huang@nxp.com>
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>

Is this patch from you or from Anson?

If it is from Anson then his name should appear at the From: line.
