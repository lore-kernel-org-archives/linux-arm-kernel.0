From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 16 Oct 2012 08:29:56 +0100
Subject: [PATCH 1/2] regulator: gpio-regulator: Allow use of GPIO
 controlled regulators though DT
In-Reply-To: <20121016051401.GB8670@opensource.wolfsonmicro.com>
References: <1350307020-5910-1-git-send-email-lee.jones@linaro.org>
 <20121016051401.GB8670@opensource.wolfsonmicro.com>
Message-ID: <20121016072956.GF7662@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 16 Oct 2012, Mark Brown wrote:

> On Mon, Oct 15, 2012 at 02:16:59PM +0100, Lee Jones wrote:
> > Here we provide the GPIO Regulator driver with Device Tree capability, so
> > that when a platform is booting with DT instead of platform data we can
> > still make full use of it.
> 
> Not looked at the patch yet but patch 2 doesn't seem to have appeared?

Has it arrived yet?

Arnd responded to it, so it hit the list.

Since Arnd's comments I've also fired v2 up - do you see it/them?

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
