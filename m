From: marex@denx.de (Marek Vasut)
Date: Thu, 4 Jun 2015 01:04:08 +0200
Subject: [PATCH 10/11] spi: add more debug prints in s3c64xx
In-Reply-To: <305830ebf9c0ae98c4f6e0ebbdec7414d6762b36.1433364398.git.hramrach@gmail.com>
References: <cover.1433364398.git.hramrach@gmail.com>
 <305830ebf9c0ae98c4f6e0ebbdec7414d6762b36.1433364398.git.hramrach@gmail.com>
Message-ID: <201506040104.08192.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, June 03, 2015 at 11:26:42 PM, Michal Suchanek wrote:
> The SPI NOR transfers mysteriously fail so add more debug prints about
> SPI transactions.
> 
> Signed-off-by: Michal Suchanek <hramrach@gmail.com>

dev_dbg() and friends would certainly be nicer here.

Best regards,
Marek Vasut
