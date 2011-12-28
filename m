From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 28 Dec 2011 12:32:53 +0000
Subject: [PATCH] ARM: S3C64XX: Remove hsmmc1 from Cragganmore
In-Reply-To: <1325075179-17187-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1325075179-17187-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <20111228123253.GJ24405@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 28, 2011 at 12:26:19PM +0000, Mark Brown wrote:
> The second MMC slot was only present on revision 1 of Cragganmore so
> remove it. Only MMC0 and MMC2 are there on production systems.

Sorry, ignore this - wrong slot.
