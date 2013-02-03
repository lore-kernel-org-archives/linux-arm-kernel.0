From: sameo@linux.intel.com (Samuel Ortiz)
Date: Sun, 3 Feb 2013 23:31:43 +0100
Subject: [PATCH] mfd: remove redundant devm_* for 88pm80x PMIC
In-Reply-To: <1358822625-5948-1-git-send-email-yizhang@marvell.com>
References: <1358822625-5948-1-git-send-email-yizhang@marvell.com>
Message-ID: <20130203223143.GV8476@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yi,

On Tue, Jan 22, 2013 at 10:43:45AM +0800, Yi Zhang wrote:
> devm_* functions are device managed and make error handling
> and code simpler; it also fix error exit paths
> 
> Signed-off-by: Yi Zhang <yizhang@marvell.com>
> ---
>  drivers/mfd/88pm800.c       |   10 +++-------
>  drivers/mfd/88pm805.c       |    4 ++--
>  drivers/mfd/88pm80x.c       |   22 ++++------------------
>  include/linux/mfd/88pm80x.h |    2 +-
>  4 files changed, 10 insertions(+), 28 deletions(-)
Applied, thanks for the fix.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
