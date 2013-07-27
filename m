From: dwmw2@infradead.org (David Woodhouse)
Date: Sat, 27 Jul 2013 21:03:09 +0100
Subject: [Ksummit-2013-discuss] DT bindings as ABI [was: Do we have
 people interested in device tree janitoring / cleanup?]
In-Reply-To: <CAKON4OymA55w_V=oP4BL2su84m8EnPgdhnQtyLWKaAJE-yNBkQ@mail.gmail.com>
References: <20130725175702.GC22291@e106331-lin.cambridge.arm.com>
 <2007664.vYsECFSKrV@flatron> <51F39FD8.6080808@broadcom.com>
 <2460092.aLmjrOVh1g@flatron> <51F3A82E.2000907@broadcom.com>
 <CACxGe6t0C7PTiDDaFkgoMZWUpBVokasxwZpV6HEtf3LaPi4qUw@mail.gmail.com>
 <CAKON4OymA55w_V=oP4BL2su84m8EnPgdhnQtyLWKaAJE-yNBkQ@mail.gmail.com>
Message-ID: <1374955389.2923.101.camel@shinybook.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2013-07-27 at 16:01 -0400, jonsmirl at gmail.com wrote:
> 
> Much cleaner to modify dtc to take a schema as part of the compilation
> process. The schema language itself has no requirement to look like
> DTS syntax. Whoever wrote dtc probably has a favorite language that
> would be good for writing schemas in.

Yes, we *definitely* want dtc to be doing the validation when it builds
trees. And warning (and needing an additional and suitably scarily named
command line option) if you try to build something *without* a schema.

-- 
dwmw2

-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 5745 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130727/664eb53a/attachment-0001.bin>
