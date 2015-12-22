From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 22 Dec 2015 23:07:22 +0100
Subject: [RFC PATCH 3/5] crypto: sunxi-ss: fix dev_dbg() output type
In-Reply-To: <1450787267-26836-4-git-send-email-andre.przywara@arm.com>
References: <1450787267-26836-1-git-send-email-andre.przywara@arm.com>
 <1450787267-26836-4-git-send-email-andre.przywara@arm.com>
Message-ID: <201512222307.22670.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 22 December 2015, Andre Przywara wrote:
> The length parameter in this dev_dbg() call is actually a size_t,
> so use the proper type to avoid warnings when compiling for 64-bit
> architectures.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
