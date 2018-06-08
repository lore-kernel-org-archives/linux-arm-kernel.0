From: pp@emlix.com (Philipp Puschmann)
Date: Fri, 8 Jun 2018 12:21:56 +0200
Subject: [PATCH] clk: imx6: fix video_27m parent for IMX6SX_CLK_CKO1_SEL
In-Reply-To: <CAOMZO5B-T2UWdv-tf5vsCuRQ6f_o1gw1pAn-b6h9zfmi5ng4Ug@mail.gmail.com>
References: <20180606092928.11724-1-pp@emlix.com>
 <CAOMZO5B-T2UWdv-tf5vsCuRQ6f_o1gw1pAn-b6h9zfmi5ng4Ug@mail.gmail.com>
Message-ID: <5cd0f6eb-9c90-f89c-7fc4-7b2bfae99809@emlix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I screwed up the title: IMX6SX_CLK_CKO1_SEL instead of IMX6QDL_CLK_CKO1_SEL

I have resent the patch with correct title. Sorry for the inconvenience.

Am 06.06.2018 um 15:07 schrieb Fabio Estevam:
> On Wed, Jun 6, 2018 at 6:29 AM, Philipp Puschmann <pp@emlix.com> wrote:
>> q/dl datasheets list the 5th selection value for ck01_sel as
>> video_27M_clk_root.
>>
>> By replacing the dummy value we then can set IMX6QDL_CLK_VIDEO_27M
>> as parent for IMX6QDL_CLK_CKO1_SEL.
>>
>> Signed-off-by: Philipp Puschmann <pp@emlix.com>
> 
> Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
