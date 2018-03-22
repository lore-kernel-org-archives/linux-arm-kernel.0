From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 22 Mar 2018 09:31:03 -0300
Subject: [PATCH 2/4] arm: imx: Correct dram pll type
In-Reply-To: <1521712529-632-3-git-send-email-abel.vesa@nxp.com>
References: <1521712529-632-1-git-send-email-abel.vesa@nxp.com>
 <1521712529-632-3-git-send-email-abel.vesa@nxp.com>
Message-ID: <CAOMZO5BVxp7pq44pUp444CqsYcJ5QQFqrgdRyFbaxRi0_d0ssg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Abel,

On Thu, Mar 22, 2018 at 6:55 AM, Abel Vesa <abel.vesa@nxp.com> wrote:
> From: Anson Huang <anson.huang@nxp.com>
>
> DRAM PLL is a audio/video type PLL, need to correct it to get correct ops of
> PLL.
>
> There is a test_div placed before DRAM PLL's gate, so add this test div clk.
>
> Signed-off-by: Anson Huang <anson.huang@nxp.com>
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>

This has already been applied in linux-next as commit:

commit b716aad97eb5 ("clk: imx: imx7d: correct video pll clock tree)

Nit: the prefix in the Subject lines of all these patches should not
be "arm:imx".

"clk: imx: imx7d" is better suited to reflect the subsystem that thes
patches touch.
