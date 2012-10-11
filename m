From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 11 Oct 2012 13:50:26 +0900
Subject: [PATCH v3] regulator: Versatile Express regulator driver
In-Reply-To: <1348509414-21261-2-git-send-email-pawel.moll@arm.com>
References: <1348509414-21261-1-git-send-email-pawel.moll@arm.com>
 <1348509414-21261-2-git-send-email-pawel.moll@arm.com>
Message-ID: <20121011045026.GB21451@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 24, 2012 at 06:56:54PM +0100, Pawel Moll wrote:
> Implementation of the regulator framework driver for the
> Versatile Express voltage control. Devices without
> voltage constraints (ie. "regulator-[min|max]-microvolt"
> properties in the DT node) are treated as fixed (or rather
> read-only) regulators.

Applied, thanks.
