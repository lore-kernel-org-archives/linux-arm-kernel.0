From: pp@emlix.com (Philipp Puschmann)
Date: Mon, 11 Jun 2018 16:12:58 +0200
Subject: [PATCH] clk: imx6: fix video_27m parent for IMX6QDL_CLK_CKO1_SEL
In-Reply-To: <CAOMZO5C8CA02V+oiag5tGpKBWN+UP28KwQ98jQ9PpQ2_aCq_bA@mail.gmail.com>
References: <20180608101924.31195-1-pp@emlix.com>
 <CAOMZO5C8CA02V+oiag5tGpKBWN+UP28KwQ98jQ9PpQ2_aCq_bA@mail.gmail.com>
Message-ID: <40261c5f-285f-66f3-41dc-7107c487a47e@emlix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Hi Philipp,
> 
> On Fri, Jun 8, 2018 at 7:19 AM, Philipp Puschmann <pp@emlix.com> wrote:
>> q/dl datasheets list the 5th selection value for ck01_sel as
>> video_27M_clk_root.
>>
>> By replacing the dummy value we then can set IMX6QDL_CLK_VIDEO_27M
>> as parent for IMX6QDL_CLK_CKO1_SEL.
>>
>> Signed-off-by: Philipp Puschmann <pp@emlix.com>
> 
> You could still have added my Reviewed-by tag that I sent previously :-)
> 
> Here it goes:
> 
> Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
> 
> Also in the future, when posting a new version of a patch, please mark
> it as such:
> 
> [PATCH v2] clk: imx6: fix video_27m parent for IMX6QDL_CLK_CKO1_SEL
> 
> and write below the --- line what are the changes in this new version.
> 
> Thanks
> 

Hi Fabio,

thank you for your hints, next time i will do it that way
