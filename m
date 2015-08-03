From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 3 Aug 2015 11:28:39 +0200
Subject: [linux-sunxi] [PATCH] ARM: dts: sunxi: Raise minimum CPU voltage
 for sun7i-a20 to a level all boards can supply
In-Reply-To: <CAGRGNgXH90m9h0DDejd5MTf8enduGFQ8dPKrRhmc8Z6y_PaC1w@mail.gmail.com>
References: <1438543386-7253-1-git-send-email-public_timo.s@silentcreek.de>
 <CAGRGNgV6b9yt2HnB2x2Wyc05KEahoX-Y+mVhxsryztcfA36H1g@mail.gmail.com>
 <CAGb2v67o-=_cL2RWfXJ+3C86zfQ_1b5DYRi3_zwvwy6su6+gdw@mail.gmail.com>
 <CAGRGNgXH90m9h0DDejd5MTf8enduGFQ8dPKrRhmc8Z6y_PaC1w@mail.gmail.com>
Message-ID: <20150803092839.GB2564@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 03, 2015 at 02:22:13PM +1000, Julian Calaby wrote:
> >> Is the code that uses this smart enough to sensibly switch between two
> >> operating points with the same frequency and different voltages? If
> >> so, maybe just add a 144MHz @ 1.0v operating point?
> >
> > You could try. Though I really don't see much to gain here.
> 
> From what I recall, lower frequency = less power usage, though my
> experience is from x86 laptops, not ARM SoCs and I'm sure I'm missing
> a lot of details. This is the sort of thing that requires thorough
> testing on a dev board.

Not on *a* dev board. On virtually all the A20 SoCs ever produced. If
you have a setting that works better for *your* SoC, fine, patch your
DT, but that's not going to be a default if it's outside of the SoC
operating range.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150803/94c58540/attachment.sig>
