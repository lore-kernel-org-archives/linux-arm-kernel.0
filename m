From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 29 Apr 2015 22:27:52 +0200
Subject: [PATCH v6 4/4] clk: dt: Introduce binding for always-on clock
 support
In-Reply-To: <20150429151147.GX9169@x1>
References: <20150407191746.GA26727@lukather> <20150408081450.GB5162@x1>
 <20150408094349.GC26727@lukather> <20150408103832.GG5162@x1>
 <20150408155705.GF26727@lukather> <20150408172344.GH5162@x1>
 <20150422093446.GA28007@lukather> <20150429141751.GR9169@x1>
 <CAMuHMdVdtoXGhK97Ky5hoVcjM6XZAZXKWELL64MFQebMpFr2Ng@mail.gmail.com>
 <20150429151147.GX9169@x1>
Message-ID: <20150429202752.GH6062@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 29, 2015 at 04:11:47PM +0100, Lee Jones wrote:
> On Wed, 29 Apr 2015, Geert Uytterhoeven wrote:
> > On Wed, Apr 29, 2015 at 4:17 PM, Lee Jones <lee.jones@linaro.org> wrote:
> > > This useful binding should be accepted and people should not abuse
> > > it.  If they do and the vendor Maintainer's review and accept then
> > > they have no foundation for recourse.
> > >
> > > Would you prefer it if I made the warning starker?
> > 
> > Perhaps you can add a check for "clock-always-on" to scripts/checkpatch.pl,
> > to make people aware they should think twice?
> 
> That's a really nice idea!
> 
> Maxime, would that make you happ(y|ier)?

Do whatever you want.

This binding is going to be merged no matter what, so my opinion has
really little value here.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150429/18aae93d/attachment.sig>
