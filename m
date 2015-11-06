From: horms@verge.net.au (Simon Horman)
Date: Fri, 6 Nov 2015 10:41:38 +0900
Subject: [PATCH/RFC] ARM: shmobile: Introduce ARCH_RENESAS
In-Reply-To: <CAMuHMdXQ5tvWu4dizhpkAx1Uhq9cSM8mj2JhWJUSxDx+Jyk2tQ@mail.gmail.com>
References: <1446702397-24078-1-git-send-email-horms+renesas@verge.net.au>
 <CAMuHMdXQ5tvWu4dizhpkAx1Uhq9cSM8mj2JhWJUSxDx+Jyk2tQ@mail.gmail.com>
Message-ID: <20151106014137.GA17493@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 05, 2015 at 07:58:46PM +0100, Geert Uytterhoeven wrote:
> On Thu, Nov 5, 2015 at 6:46 AM, Simon Horman <horms+renesas@verge.net.au> wrote:
> > The purpose of this patch is to start the process of replacing both
> > ARCH_SHMOBILE and ARCH_SHMOBILE_MULTI with ARCH_RENESAS. The motivation
> > being that as time has moved on Renesas has become a name than shmobile for
> > the majority Renesas 32-bit ARM based SoCs. The name is, conveniently, also
> > applicable to (older) Renesas SH based SoCs and (newer) ARM64 based SoCs
> > although this patch only addresses 32-bit ARM.
> 
> Is this supposed to include H8/300 and m32r in the future?

Hi Geert,

my main aim is to replace ARCH_SHMOBILE and ARCH_SHMOBILE_MULTI with
ARCH_RENESAS. I don't believe that would cover H8/300 and m32r,
though I am happy to stand corrected.
