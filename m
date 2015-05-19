From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue, 19 May 2015 09:14:42 +0200
Subject: at91sam9: watchdog: period
In-Reply-To: <555AA8F1.80100@atmel.com>
References: <55559D55.6020703@aksignal.cz> <20150515172516.005e3a21@bbrezillon>
 <5559865F.9010502@aksignal.cz> <20150518092750.449d6c8c@bbrezillon>
 <5559A029.9060007@aksignal.cz> <555AA8F1.80100@atmel.com>
Message-ID: <20150519091442.675b1a98@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 19 May 2015 11:07:29 +0800
"Yang, Wenyou" <wenyou.yang@atmel.com> wrote:

> 
> 
> On 2015/5/18 16:17, Ji?? Prchal wrote:
> >
> >
> > On 18.5.2015 09:27, Boris Brezillon wrote:
> >>
> >> Can you dump watchdog registers (using devmem) ?
> >
> > / # devmem 0xfffffe40
> > 0x00000000
> > / # devmem 0xfffffe44
> > 0x1FFF2FFF
> > / # devmem 0xfffffe48
> > 0x00000000
> >
> The register value is right.

It seems correct to me too.

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
