From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 23 Feb 2015 12:23:03 +0100
Subject: [PATCH] PCI: xgene: Fix the map_bus callback prototype
In-Reply-To: <1424686899-7869-1-git-send-email-tranmanphong@gmail.com>
References: <1424686899-7869-1-git-send-email-tranmanphong@gmail.com>
Message-ID: <18992705.dPyaFqicRN@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 23 February 2015 17:21:39 Phong Tran wrote:
> The return value should be void __iomem *.
> Tested by compile only.
> 
> Signed-off-by: Phong Tran <tranmanphong@gmail.com>
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>

Thanks for the fix, I had noticed this in the build bot logs
but not yet reported on the list.

	Arnd
