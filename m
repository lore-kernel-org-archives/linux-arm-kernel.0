From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 19 Oct 2015 15:08:50 +0200
Subject: [PATCH 0/4] VFIO platform reset module rework
In-Reply-To: <1445184015-24414-1-git-send-email-eric.auger@linaro.org>
References: <1445184015-24414-1-git-send-email-eric.auger@linaro.org>
Message-ID: <5564303.6Ntpr32PW1@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 18 October 2015 18:00:11 Eric Auger wrote:
> This series fixes the current implementation by getting rid of the
> usage of __symbol_get which caused a compilation issue with
> CONFIG_MODULES disabled. On top of this, the usage of MODULE_ALIAS makes
> possible to add a new reset module without being obliged to update the
> framework. The new implementation relies on the reset module registering
> its reset function to the vfio-platform driver.
> 
> The series is available at
> 
> https://git.linaro.org/people/eric.auger/linux.git/shortlog/refs/heads/v4.3-rc5-rework-xgbe-v2
> 
> 

Looks good for the most part, just a few comments on coding style
for patches 1 and 2.

	Arnd
