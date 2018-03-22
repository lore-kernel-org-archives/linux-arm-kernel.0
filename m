From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 22 Mar 2018 11:20:32 -0300
Subject: [PATCH 1/4] arm: imx: Update clk driver API
In-Reply-To: <1521712529-632-2-git-send-email-abel.vesa@nxp.com>
References: <1521712529-632-1-git-send-email-abel.vesa@nxp.com>
 <1521712529-632-2-git-send-email-abel.vesa@nxp.com>
Message-ID: <CAOMZO5DdBv0oisdRt01O-VnF_5b1oL6d2a0JGyieOiNvrut=Qg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 22, 2018 at 6:55 AM, Abel Vesa <abel.vesa@nxp.com> wrote:
> This adds the following new wrappers:
>  - imx_clk_gate2_flag
>  - imx_clk_set_parent
>
> It also updates the flags for the old wrappers.

This flag update should also be a separate patch and you should
explain the reason for it.
