From: horms@verge.net.au (Simon Horman)
Date: Mon, 23 Apr 2018 11:29:18 +0200
Subject: [PATCH/RFC 7/8] ARM: shmobile: Remove the ARCH_SHMOBILE Kconfig
 symbol
In-Reply-To: <1524230914-10175-8-git-send-email-geert+renesas@glider.be>
References: <1524230914-10175-1-git-send-email-geert+renesas@glider.be>
 <1524230914-10175-8-git-send-email-geert+renesas@glider.be>
Message-ID: <20180423092917.h24b2gem6j24uhnk@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 20, 2018 at 03:28:33PM +0200, Geert Uytterhoeven wrote:
> All drivers for Renesas ARM SoCs have gained proper ARCH_RENESAS
> platform dependencies.  Hence finish the conversion from ARCH_SHMOBILE
> to ARCH_RENESAS for Renesas 32-bit ARM SoCs, as started by commit
> 9b5ba0df4ea4f940 ("ARM: shmobile: Introduce ARCH_RENESAS").
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> This depends on the previous patches in this series, hence the RFC.

Thanks, I have marked this and the following patch as deferred.
Please repost or otherwise ping me once the dependencies are in place.
