From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 06 Oct 2015 14:37:51 +0200
Subject: [PATCH 1/2] ARM: shmobile: r8a7790 dtsi: Add CPG/MSTP Clock
 Domain for sound
In-Reply-To: <560E6B61.5000509@cogentembedded.com>
References: <cover.1443752733.git.horms+renesas@verge.net.au>
 <560E6AAE.9080605@cogentembedded.com> <560E6B61.5000509@cogentembedded.com>
Message-ID: <5814245.0FrCevzbqn@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 02 October 2015 14:32:49 Sergei Shtylyov wrote:
> On 10/2/2015 2:29 PM, Sergei Shtylyov wrote:
> 
> >> From: Geert Uytterhoeven <geert+renesas@glider.be>
> >>
> >> 484adb005886 ("ARM: shmobile: r8a7790 dtsi: Add CPG/MSTP Clock Domain")
> >> added CPG/MSTP clock-cells domain support, but it was missing sound
> >> support. This patch adds it.
> >
> >     Really? I'm only seeing "power-domains" prop added...
> 
>     Oh, I understand now. The log seems somewhat poorly worded though...

I understood it right and merged it as is, but I agree this could
have been clearer.

	Arnd
