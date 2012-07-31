From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 31 Jul 2012 14:55:39 +0100
Subject: [PATCH 18/19] Documentation: Define the MSP Driver Device Tree
 bindings
In-Reply-To: <1343741953-17828-19-git-send-email-lee.jones@linaro.org>
References: <1343741953-17828-1-git-send-email-lee.jones@linaro.org>
 <1343741953-17828-19-git-send-email-lee.jones@linaro.org>
Message-ID: <20120731135539.GO4468@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 31, 2012 at 02:39:12PM +0100, Lee Jones wrote:

> +Optional properties:
> + - interrupts       : The interrupt outputs from the device.

If there's more than one interrupt then how are they ordered?
