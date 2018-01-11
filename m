From: icenowy@aosc.io (Icenowy Zheng)
Date: Thu, 11 Jan 2018 17:38:39 +0800
Subject: [linux-sunxi] Re: [PATCH 0/7] Initial Allwinner H6 support
In-Reply-To: <CACRpkdY3xY-7-YTCS=QmRQ3hmXiJZ_2M=ZhJRTTMx7XNfXRRSw@mail.gmail.com>
References: <20180106041813.46256-1-icenowy@aosc.io>
 <CACRpkdY3xY-7-YTCS=QmRQ3hmXiJZ_2M=ZhJRTTMx7XNfXRRSw@mail.gmail.com>
Message-ID: <6025395.Uh4Z0ipbrK@ice-x220i>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2018?1?11???? CST ??5:36:39?Linus Walleij ???
> On Sat, Jan 6, 2018 at 5:18 AM, Icenowy Zheng <icenowy@aosc.io> wrote:
> > This patchset adds initial support for the Allwinner H6 SoC.
> 
> Can I apply the pin control patches without the clock patches?

I think it's OK.

Note: on H6 now the pin controller do not depend on
the CCU at all -- it only needs two oscillators now.

> 
> Also waiting for Maxime and/or Chen-Yu to provide some review
> before merging this.
> 
> Yours,
> Linus Walleij
