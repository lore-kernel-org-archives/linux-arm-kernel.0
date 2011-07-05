From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 5 Jul 2011 13:50:54 +0200
Subject: [PATCH 7/8] ARM: integrate CMA with dma-mapping subsystem
In-Reply-To: <1309851710-3828-8-git-send-email-m.szyprowski@samsung.com>
References: <1309851710-3828-1-git-send-email-m.szyprowski@samsung.com>
	<1309851710-3828-8-git-send-email-m.szyprowski@samsung.com>
Message-ID: <201107051350.54529.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 05 July 2011, Marek Szyprowski wrote:
> This patch adds support for CMA to dma-mapping subsystem for ARM
> architecture. By default a global CMA area is used, but specific devices
> are allowed to have their private memory areas if required (they can be
> created with dma_declare_contiguous() function during board
> initialization).
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
