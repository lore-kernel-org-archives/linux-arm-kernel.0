From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 30 Dec 2014 15:33:33 +0100
Subject: [PATCH] Add USB_EHCI_EXYNOS to multi_v7_defconfig
In-Reply-To: <1419922548-6320-2-git-send-email-steev@gentoo.org>
References: <1419922548-6320-1-git-send-email-steev@gentoo.org>
 <1419922548-6320-2-git-send-email-steev@gentoo.org>
Message-ID: <6304842.IclsjIO6RW@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 30 December 2014 00:55:48 Steev Klimaszewski wrote:
> Currently we enable Exynos devices in the multi v7 defconfig, however, when
> testing on my ODROID-U3, I noticed that USB was not working.  Enabling this
> option causes USB to work, which enables networking support as well since the
> ODROID-U3 has networking on the USB bus.
> 
> Signed-off-by: Steev Klimaszewski <steev@gentoo.org>

Applied to fixes branch, thanks!

	Arnd
