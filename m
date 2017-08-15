From: joro@8bytes.org (Joerg Roedel)
Date: Tue, 15 Aug 2017 17:47:26 +0200
Subject: [PATCH v2] memory: mtk-smi: Handle return value of
 clk_prepare_enable
In-Reply-To: <daeed02ff9e257286bbae9e4e496e40e4c5480c5.1502341483.git.arvind.yadav.cs@gmail.com>
References: <daeed02ff9e257286bbae9e4e496e40e4c5480c5.1502341483.git.arvind.yadav.cs@gmail.com>
Message-ID: <20170815154726.GC25618@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 10, 2017 at 10:47:32AM +0530, Arvind Yadav wrote:
> clk_prepare_enable() can fail here and we must check its return value.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---
> changes in v2:
>              Rebase patch[1]https://lkml.org/lkml/2017/8/3/968
>              and apply this change. Otherwise will merge conflict.
> 
>  drivers/memory/mtk-smi.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Applied, thanks.
