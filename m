From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Thu, 9 Jun 2011 09:46:39 +0300
Subject: [PATCH 4/4] This patch add configuraton for ok2440 development
	board.
In-Reply-To: <1307581402-3808-4-git-send-email-wdgvip@gmail.com>
References: <1307581402-3808-1-git-send-email-wdgvip@gmail.com>
	<1307581402-3808-4-git-send-email-wdgvip@gmail.com>
Message-ID: <201106090946.40337.anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 09 June 2011 04:03:22 Wu DaoGuang wrote:
> Add the default configuration for ok2440 development board.

Please, no huge defconfigs. Modify s3c2410_defconfig instead.

> Signed-off-by: Wu DaoGuang <wdgvip@gmail.com>
> ---
>  arch/arm/configs/ok2440_defconfig | 2821
> +++++++++++++++++++++++++++++++++++++ 1 files changed, 2821 insertions(+),
> 0 deletions(-)
>  create mode 100644 arch/arm/configs/ok2440_defconfig
