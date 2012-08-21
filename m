From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 21 Aug 2012 07:55:26 +0000
Subject: [PATCH 2/3] ARM: PRIMA2: make mach-prima2 common for all SiRF
 series SoC
In-Reply-To: <CAGsJ_4yWzdzJMrCqWWozKBrkSJ7O5thpP+mYTTEsN8+AuO03wA@mail.gmail.com>
References: <1345450787-17246-1-git-send-email-Barry.Song@csr.com>
 <201208202106.43206.arnd@arndb.de>
 <CAGsJ_4yWzdzJMrCqWWozKBrkSJ7O5thpP+mYTTEsN8+AuO03wA@mail.gmail.com>
Message-ID: <201208210755.26253.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 21 August 2012, Barry Song wrote:
> >
> >> +if ARCH_SIRF
> >> +
> >> +choice
> >> +       prompt "Qualcomm SiRF SoC Type"
> >> +       default ARCH_PRIMA2
> >
> > I'm curious about this: I did read that Samsung acquired CSR, and
> > you list the chips as Qualcomm. What's the story here?
> 
> BTW, i just want to clarify Samsung  acquired the mobile business of
> CSR, not including our primaII or other SoCs.

Ah, I had not realized that. Thanks for the clarification.

	Arnd
