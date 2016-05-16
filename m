From: jesper.nilsson@axis.com (Jesper Nilsson)
Date: Mon, 16 May 2016 10:00:11 +0200
Subject: [PATCH v4 06/18] cris: Remove unnecessary of_platform_populate
 with default match table
In-Reply-To: <1463054775-18170-7-git-send-email-wangkefeng.wang@huawei.com>
References: <1463054775-18170-1-git-send-email-wangkefeng.wang@huawei.com>
 <1463054775-18170-7-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <20160516080011.GB24250@axis.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 12, 2016 at 08:06:03PM +0800, Kefeng Wang wrote:
> After patch "of/platform: Add common method to populate default bus",
> it is possible for arch code to remove unnecessary callers about the
> of_platform_populate with default match table.
> 
> Cc: Mikael Starvik <starvik@axis.com>

Acked-by: Jesper Nilsson <jesper.nilsson@axis.com>

> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  arch/cris/kernel/setup.c | 8 --------
>  1 file changed, 8 deletions(-)

/^JN - Jesper Nilsson
-- 
               Jesper Nilsson -- jesper.nilsson at axis.com
