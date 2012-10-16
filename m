From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 16 Oct 2012 14:14:04 +0900
Subject: [PATCH 1/2] regulator: gpio-regulator: Allow use of GPIO
 controlled regulators though DT
In-Reply-To: <1350307020-5910-1-git-send-email-lee.jones@linaro.org>
References: <1350307020-5910-1-git-send-email-lee.jones@linaro.org>
Message-ID: <20121016051401.GB8670@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 15, 2012 at 02:16:59PM +0100, Lee Jones wrote:
> Here we provide the GPIO Regulator driver with Device Tree capability, so
> that when a platform is booting with DT instead of platform data we can
> still make full use of it.

Not looked at the patch yet but patch 2 doesn't seem to have appeared?
