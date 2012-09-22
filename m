From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sat, 22 Sep 2012 12:14:18 -0400
Subject: [PATCH v2] spi/pl022: Devicetree support w/o platform data
In-Reply-To: <1347976433-1176-1-git-send-email-stigge@antcom.de>
References: <1347976433-1176-1-git-send-email-stigge@antcom.de>
Message-ID: <20120922161418.GW4495@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 18, 2012 at 03:53:53PM +0200, Roland Stigge wrote:
> Even with devicetree support, we needed platform data to provide some data,
> leading to mixed device tree and platform data. This patch makes it possible to
> provide all that information via device tree. Now, the data must be provided
> via platform data _or_ device tree completely.

Applied, thanks.
