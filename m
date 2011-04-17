From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 17 Apr 2011 20:41:18 +0200
Subject: [PATCH 3/3] Add documenation for new sysfs devices/soc
	functionallity
In-Reply-To: <1302792592-17484-4-git-send-email-lee.jones@linaro.org>
References: <1302792592-17484-1-git-send-email-lee.jones@linaro.org>
	<1302792592-17484-4-git-send-email-lee.jones@linaro.org>
Message-ID: <201104172041.18313.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 14 April 2011, Lee Jones wrote:
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  Documentation/ABI/testing/sysfs-devices-soc |   16 ++++++++++++++++
>  1 files changed, 16 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-devices-soc

Looks good, but the patch is missing a changelog. I wouldn't bother splitting it out,
just merge this patch with the first one in the series.

	Arnd
