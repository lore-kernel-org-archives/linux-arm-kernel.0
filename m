From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 21 Mar 2012 19:56:34 +0000
Subject: [PATCH] clk: Constify parent name arrays
In-Reply-To: <1332357307-10693-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1332357307-10693-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <20120321195633.GB27778@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 21, 2012 at 07:15:07PM +0000, Mark Brown wrote:
> Drivers should be able to declare their arrays of parent names as const
> so the APIs need to accept const arguments.

Slight oversight in this one and the updates for the new API version
were simpler than I thought so sending a new version shortly.
