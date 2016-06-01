From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 1 Jun 2016 17:04:02 +0100
Subject: [PATCH] include/linux/arm-smccc.h: avoid sign extension problem
In-Reply-To: <1464785361-20038-1-git-send-email-jens.wiklander@linaro.org>
References: <1464785361-20038-1-git-send-email-jens.wiklander@linaro.org>
Message-ID: <20160601160401.GZ19428@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 01, 2016 at 02:49:21PM +0200, Jens Wiklander wrote:
> Prior to this patch the ARM_SMCCC_FAST_CALL constant was of a signed
> type causing unwanted sign extension. This patch explicitly selects an
> unsigned type for the constant.
> 
> Reported-by: Saksham Jain <sakjain92@gmail.com>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>

Looks fine to me.  Who's merging this change?  If they're going some
other route:

Acked-by: Russell King <rmk+kernel@armlinux.org.uk>

Thanks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
