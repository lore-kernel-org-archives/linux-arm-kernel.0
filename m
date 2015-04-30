From: horms@verge.net.au (Simon Horman)
Date: Thu, 30 Apr 2015 09:15:48 +0900
Subject: [PATCH 0/3] ARM: shmobile: Use generic names for sound device
 nodes
In-Reply-To: <1430216963-8161-1-git-send-email-geert+renesas@glider.be>
References: <1430216963-8161-1-git-send-email-geert+renesas@glider.be>
Message-ID: <20150430001548.GE17758@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 28, 2015 at 12:29:20PM +0200, Geert Uytterhoeven wrote:
> 	Hi Magnus, Simon,
> 
> This patch series gets rid of the "sound-codec" device nodes names in
> the shmobile DTS files, and replaces them by "codec", as the former
> doesn't appear in any binding document.
> 
> Thanks for applying!

Thanks, I have queued these up for v4.2.

> Geert Uytterhoeven (3):
>   ARM: shmobile: bockw dts: Use generic names for device nodes
>   ARM: shmobile: lager dts: Use generic names for device nodes
>   ARM: shmobile: koelsch dts: Use generic names for device nodes
> 
>  arch/arm/boot/dts/r8a7778-bockw.dts   | 2 +-
>  arch/arm/boot/dts/r8a7790-lager.dts   | 2 +-
>  arch/arm/boot/dts/r8a7791-koelsch.dts | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
