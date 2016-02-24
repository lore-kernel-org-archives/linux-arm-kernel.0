From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 24 Feb 2016 22:20:55 +0100
Subject: [PATCH v3 6/6] arm: lpc32xx: phy3250 remove restart hook
In-Reply-To: <1456336018-6620-7-git-send-email-slemieux.tyco@gmail.com>
References: <1456336018-6620-1-git-send-email-slemieux.tyco@gmail.com>
 <1456336018-6620-7-git-send-email-slemieux.tyco@gmail.com>
Message-ID: <2913764.6ZXbKHTUYJ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 24 February 2016 12:46:58 Sylvain Lemieux wrote:
> From: Sylvain Lemieux <slemieux@tycoint.com>
> 
> Remove the restart hook assignment from phy3250;
> this functionality is now managed by
> the pnx4008 watchdog driver.
> 
> Signed-off-by: Sylvain Lemieux <slemieux@tycoint.com>
> ---
> Note:
> This patch was generated with the option "--unified=2" to ensure
> it can be apply before or after the following git pull request
> for the LPC32xx platform:
> - http://permalink.gmane.org/gmane.linux.ports.arm.kernel/477137
> - http://permalink.gmane.org/gmane.linux.ports.arm.kernel/477138

This patch really needs to come before patch 5 in the series, or
you could combine the two into a single patch.

	Arnd
