From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 28 Jan 2016 12:27:52 +0100
Subject: [PATCH v2] clk: Move vendor's Kconfig into CCF menu section
In-Reply-To: <1453971537-5510-1-git-send-email-jamesjj.liao@mediatek.com>
References: <1453971537-5510-1-git-send-email-jamesjj.liao@mediatek.com>
Message-ID: <1934810.PcLUxJgllT@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 28 January 2016 16:58:57 James Liao wrote:
> Move all vendor's Kconfig into CCF menu section to prevent
> new drivers putting their Kconfig files in a wrong place.
> 
> Some Kconigs need to modify at the same time to avoid build
> warnings.
> 
> Signed-off-by: James Liao <jamesjj.liao@mediatek.com>
> ---
> This patch is based on v4.5-rc1.
> 
> changes since v1:
> - Modify s3c24xx and samsung's Kconfig to avoid build warngings.
> 
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>
