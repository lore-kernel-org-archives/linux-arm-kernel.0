From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 07 Jul 2011 15:14:58 -0400 (EDT)
Subject: [PATCH] ARM: support XZ compressed kernels
In-Reply-To: <1310033999-25617-1-git-send-email-kaloz@openwrt.org>
References: <1310033999-25617-1-git-send-email-kaloz@openwrt.org>
Message-ID: <alpine.LFD.2.00.1107071513440.14596@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 7 Jul 2011, Imre Kaloz wrote:

> Wire up support for the XZ decompressor
> 
> Signed-off-by: Imre Kaloz <kaloz@openwrt.org>
> ---
>  arch/arm/Kconfig                        |    1 +
>  arch/arm/boot/compressed/Makefile       |   11 +++++++++--
>  arch/arm/boot/compressed/decompress.c   |    4 ++++
>  arch/arm/boot/compressed/piggy.xzkern.S |    6 ++++++
>  lib/xz/xz_dec_stream.c                  |    1 +
>  5 files changed, 21 insertions(+), 2 deletions(-)

Please don't forget to update arch/arm/boot/compressed/.gitignore


Nicolas
