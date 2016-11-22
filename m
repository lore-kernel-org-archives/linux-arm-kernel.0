From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 22 Nov 2016 10:31:19 +0100
Subject: [RFC PATCH 04/11] PCI: tegra: limit to MMU build only
In-Reply-To: <1479806768-39911-5-git-send-email-vladimir.murzin@arm.com>
References: <1479806768-39911-1-git-send-email-vladimir.murzin@arm.com>
 <1479806768-39911-5-git-send-email-vladimir.murzin@arm.com>
Message-ID: <11637152.Dd0IBkEQ8q@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, November 22, 2016 9:26:01 AM CET Vladimir Murzin wrote:
> This driver uses functionality which available for MMU build only,
> thus add dependency on MMU.
> 
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
> 

Can you be more specific about what requires the MMU here?

Is it the I/O space remapping or something else?

	Arnd
