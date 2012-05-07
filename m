From: sameo@linux.intel.com (Samuel Ortiz)
Date: Mon, 7 May 2012 10:12:11 +0200
Subject: [PATCH 1/2] mfd: max8925: request resource region
In-Reply-To: <1336360249-29963-1-git-send-email-haojian.zhuang@gmail.com>
References: <1336360249-29963-1-git-send-email-haojian.zhuang@gmail.com>
Message-ID: <20120507081211.GC3229@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Haojian,

On Mon, May 07, 2012 at 11:10:48AM +0800, Haojian Zhuang wrote:
> If resource region isn't requested, component devices will fail to request
> their resources.
>
> Signed-off-by: Haojian Zhuang <haojian.zhuang@gmail.com>
> ---
>  drivers/mfd/max8925-core.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
Applied to my for-next branch, thanks.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
