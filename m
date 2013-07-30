From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 30 Jul 2013 10:30:45 -0600
Subject: [Ksummit-2013-discuss] DT bindings as ABI [was: Do we have people
 interested in device tree janitoring / cleanup?]
In-Reply-To: <CAKON4OyWuF+qm2MAhbXnGg=ozzw37kpSWciLxyUy+QQzxoWdxQ@mail.gmail.com>
References: <20130725175702.GC22291@e106331-lin.cambridge.arm.com>
 <2007664.vYsECFSKrV@flatron> <51F39FD8.6080808@broadcom.com>
 <2460092.aLmjrOVh1g@flatron> <51F3A82E.2000907@broadcom.com>
 <CACxGe6t0C7PTiDDaFkgoMZWUpBVokasxwZpV6HEtf3LaPi4qUw@mail.gmail.com>
 <CAKON4OymA55w_V=oP4BL2su84m8EnPgdhnQtyLWKaAJE-yNBkQ@mail.gmail.com>
 <CACxGe6uE6jOE-vz0onW5h93Es-soGiBAcFBM7Dvxh+HvCNrHkw@mail.gmail.com>
 <CACxGe6vw9=y5a+EgF1gO39SwGAdGofD2MYjyJ3jYu6uN3ke70A@mail.gmail.com>
 <1374988276.1973.29.camel@dabdike> <20130730014453.GJ29970@voom.fritz.box>
 <CAKON4OyWuF+qm2MAhbXnGg=ozzw37kpSWciLxyUy+QQzxoWdxQ@mail.gmail.com>
Message-ID: <51F7EA35.6070501@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/29/2013 08:15 PM, jonsmirl at gmail.com wrote:
> On Mon, Jul 29, 2013 at 9:44 PM, David Gibson
> <david@gibson.dropbear.id.au> wrote:
...
>> I also think we should consider the option of having a simple and
>> straightforward schema language which handles, say, 80% of cases with
>> a fall back to C for the 20% of curly cases.  That might actually be
>> simpler to work with in practice than a schema language which can
>> express absolutely anything, at the cost of being awkward for simple
>> cases or difficult to get your head around.
> 
> Would C++ work? You can use operating overloading and templates to
> change the syntax into something that doesn't even resemble C any
> more.

>From my perspective, that's precisely why C++ should /not/ be used.
