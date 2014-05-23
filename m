From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 23 May 2014 15:57:19 +0200
Subject: [Ksummit-discuss] [TECH TOPIC] ARM legacy board DT conversion
 finalization
In-Reply-To: <CACRpkdZEyHpnmfdXRQjt3mgZu4Nx62osLv+7f5TKtURW8YXZ+Q@mail.gmail.com>
References: <20140511030009.GO12708@titan.lakedaemon.net>
 <CAL_JsqJw11fZBbLVi=xxC559iWdwCMFOJ4XYM-8EjykttoWsOg@mail.gmail.com>
 <CACRpkdZEyHpnmfdXRQjt3mgZu4Nx62osLv+7f5TKtURW8YXZ+Q@mail.gmail.com>
Message-ID: <32559195.sfqtkZmVxi@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 23 May 2014 15:40:15 Linus Walleij wrote:
> On Thu, May 15, 2014 at 8:50 PM, Rob Herring <robh@kernel.org> wrote:
> 
> > I do think having todo lists would be valuable. I would like to see
> > more than a one off list and have a living document. Linus W had a
> > great spreadsheet on this for multi-platform enablement. Perhaps this
> > would spur people to do some of the clean-ups (or it will just bit rot
> >  ).
> 
> It's still there:
> https://docs.google.com/spreadsheet/ccc?key=0Aj_PQh-9xwkMdHRHYzRzOEhyMEt5b3UtOFIwcHRpWEE
> 
> However I don't think there is much to discuss really. It's just work,
> we know how to do it.
> 
> The real problem is that of somebody doing the work, and when maintainers
> don't want to do the work, how to proceed by leaving the platform as-is
> (legacy), delete it (lacking active maintainer) or have some custodian
> like me acquire the hardware and fix it up myself.
> 
> Arnd and I have discussed this and we basically think that the StrongARM
> stuff (RISC PC, Netwinder, SA1100-based handhelds etc) are legacy
> systems while all ARMv4T and later are target for modernization if
> and only if an active maintainer is available to pursue the work.

I was also including the XScale based platforms (ixp, iop, pxa) in the
same category as StrongARM, although PXA sticks out a bit as there is new
development going on for that platform.

	Arnd
