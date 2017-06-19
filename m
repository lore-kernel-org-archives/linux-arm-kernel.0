From: olof@lixom.net (Olof Johansson)
Date: Sun, 18 Jun 2017 22:44:20 -0700
Subject: [GIT PULL] Second Round of Renesas ARM64 Based SoC DT Updates
 for v4.13
In-Reply-To: <cover.1497617276.git.horms+renesas@verge.net.au>
References: <cover.1497617276.git.horms+renesas@verge.net.au>
Message-ID: <20170619054420.GH7703@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Fri, Jun 16, 2017 at 03:30:17PM +0200, Simon Horman wrote:
> Hi Olof, Hi Kevin, Hi Arnd,
> 
> Please consider these second round of Renesas ARM64 based SoC DT updates
> for v4.13.
> 
> This pull request is based on the previous round of
> such requests, tagged as renesas-arm64-dt-for-v4.13,
> which you have already pulled.
> 
> 
> The following changes since commit 0b03c32db03d63de695c1e0ab1950eb12b135fa7:
> 
>   arm64: dts: r8a7795: salvator-x: Add support for R-Car H3 ES2.0 (2017-05-22 14:54:57 +0200)
> 
> are available in the git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-arm64-dt2-for-v4.13
> 
> for you to fetch changes up to 4d1255ebefb6838eab4f652107433438bea0051f:
> 
>   arm64: dts: r8a7796: Add reset control properties for audio (2017-06-14 11:00:29 +0200)
> 
> ----------------------------------------------------------------
> Second Round of Renesas ARM64 Based SoC DT Updates for v4.13
> 
> * Add reset control properties for audio to r9a779[56] SoCs
> * Add add DMA for IIC_DVFS to r9a779[56] SoCs
> * Add support for Salvator-XS and H3ULCB with R-Car H3 (r8a7795) ES2
> * Add missing index to PWM pinctrl subnode name to Salvator-X board
> * Add 12288000 for sound ADG to Salvator-X and ULCB boards

This doesn't mean anything to me. Even if I happened to know what ADG is,
I'm not sure what ADG+12288000 is!?

Looking at the patch, it adds a 12288000 clock to the audio block to be able to
play 48k audio. Maybe that's what you meant to say here?

Merged anyway this time.


-Olof
