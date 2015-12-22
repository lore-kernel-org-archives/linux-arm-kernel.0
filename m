From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 22 Dec 2015 23:02:46 +0100
Subject: [RFC PATCH 1/5] drivers: sunxi-rsb: fix error output type
In-Reply-To: <1450787267-26836-2-git-send-email-andre.przywara@arm.com>
References: <1450787267-26836-1-git-send-email-andre.przywara@arm.com>
 <1450787267-26836-2-git-send-email-andre.przywara@arm.com>
Message-ID: <201512222302.46491.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 22 December 2015, Andre Przywara wrote:
> "len" is actually a size_t in this function here, so properly annotate
> the dev_err printf type to allow compilation for 64-bit architectures.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Acked-by: 
