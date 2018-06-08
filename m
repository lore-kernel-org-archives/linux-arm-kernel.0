From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 8 Jun 2018 10:00:52 -0300
Subject: [PATCH] clk: imx6: fix video_27m parent for IMX6QDL_CLK_CKO1_SEL
In-Reply-To: <20180608101924.31195-1-pp@emlix.com>
References: <20180608101924.31195-1-pp@emlix.com>
Message-ID: <CAOMZO5C8CA02V+oiag5tGpKBWN+UP28KwQ98jQ9PpQ2_aCq_bA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philipp,

On Fri, Jun 8, 2018 at 7:19 AM, Philipp Puschmann <pp@emlix.com> wrote:
> q/dl datasheets list the 5th selection value for ck01_sel as
> video_27M_clk_root.
>
> By replacing the dummy value we then can set IMX6QDL_CLK_VIDEO_27M
> as parent for IMX6QDL_CLK_CKO1_SEL.
>
> Signed-off-by: Philipp Puschmann <pp@emlix.com>

You could still have added my Reviewed-by tag that I sent previously :-)

Here it goes:

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>

Also in the future, when posting a new version of a patch, please mark
it as such:

[PATCH v2] clk: imx6: fix video_27m parent for IMX6QDL_CLK_CKO1_SEL

and write below the --- line what are the changes in this new version.

Thanks
