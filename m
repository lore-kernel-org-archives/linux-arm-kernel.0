From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 6 Jun 2018 10:07:18 -0300
Subject: [PATCH] clk: imx6: fix video_27m parent for IMX6SX_CLK_CKO1_SEL
In-Reply-To: <20180606092928.11724-1-pp@emlix.com>
References: <20180606092928.11724-1-pp@emlix.com>
Message-ID: <CAOMZO5B-T2UWdv-tf5vsCuRQ6f_o1gw1pAn-b6h9zfmi5ng4Ug@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 6, 2018 at 6:29 AM, Philipp Puschmann <pp@emlix.com> wrote:
> q/dl datasheets list the 5th selection value for ck01_sel as
> video_27M_clk_root.
>
> By replacing the dummy value we then can set IMX6QDL_CLK_VIDEO_27M
> as parent for IMX6QDL_CLK_CKO1_SEL.
>
> Signed-off-by: Philipp Puschmann <pp@emlix.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
