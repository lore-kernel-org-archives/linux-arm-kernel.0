From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 15 Nov 2013 13:31:45 +0100
Subject: [PATCH 0/3] ata: Add APM X-Gene SoC 6.0Gbps SATA PHY support
In-Reply-To: <1384457519-21335-1-git-send-email-lho@apm.com>
References: <1384457519-21335-1-git-send-email-lho@apm.com>
Message-ID: <201311151331.46341.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 14 November 2013, Loc Ho wrote:
> ata: Add APM X-Gene SoC 6.0Gbps SATA PHY support
> 
> This patch adds support for APM X-Gene SoC 6.0Gbps SATA PHY. This is the
> physical layer interface for the corresponding SATA host controller. This
> driver uses the new PHY generic framework posted by Kishon Vijay Abrahm.
> 
> Signed-off-by: Loc Ho <lho@apm.com>
> Signed-off-by: Tuan Phan <tphan@apm.com>
> Signed-off-by: Suman Tripathi <stripathi@apm.com>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> Reviewed-by: Olof Johansson <olof@lixom.net> 

Please remove the "Reviewed-by" tags and only add them back after you get
a reply with the respective comment. Tags like "Reviewed-by", "Acked-by"
or "Tested-by" are meant to signify that the reviewer or tester
has looked at them and is happy with the results, which is not yet
the case here.

	Arnd
