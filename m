From: ckeepax@opensource.wolfsonmicro.com (Charles Keepax)
Date: Tue, 26 Jan 2016 15:10:14 +0000
Subject: [PATCH] ARM: s3c64xx: Select GPIO_GENERIC_PLATFORM for Cragganmore
In-Reply-To: <1453400718-26720-1-git-send-email-broonie@kernel.org>
References: <1453400718-26720-1-git-send-email-broonie@kernel.org>
Message-ID: <20160126151014.GL1490@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 21, 2016 at 06:25:18PM +0000, Mark Brown wrote:
> The Cragganmore machine driver provides platform data for the generic GPIO
> platform driver which uses structures only defined if the driver is
> enabled. Since there is little reason to use the platform without the GPIOs
> add a select to avoid build failures.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---

All looks good to me and doesn't cause any issues on my Speyside.

Tested-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles
