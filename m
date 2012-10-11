From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 11 Oct 2012 13:50:08 +0900
Subject: [RFC] regulator: core: Support for continuous voltage range
In-Reply-To: <1348509414-21261-1-git-send-email-pawel.moll@arm.com>
References: <1348509414-21261-1-git-send-email-pawel.moll@arm.com>
Message-ID: <20121011044954.GA21451@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 24, 2012 at 06:56:53PM +0100, Pawel Moll wrote:
> Some regulators can set any voltage within the constraints range,
> not being limited to specified operating points.
> 
> This patch makes it possible to describe such regulator and makes
> the regulator_is_supported_voltage() function behave correctly.

Applied, thanks.
