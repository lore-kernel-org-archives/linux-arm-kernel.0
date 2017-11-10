From: horms@verge.net.au (Simon Horman)
Date: Fri, 10 Nov 2017 12:36:24 +0100
Subject: [PATCH 1/7] arm64: dts: renesas: r8a7796: Add IPMMU device nodes
In-Reply-To: <CAMuHMdWdPmU=16B8BbfTD316MWOGVVhb4-vcg7yr-JBLKDwjdg@mail.gmail.com>
References: <20171101103458.7582-1-horms+renesas@verge.net.au>
 <20171101103458.7582-2-horms+renesas@verge.net.au>
 <CAMuHMdWdPmU=16B8BbfTD316MWOGVVhb4-vcg7yr-JBLKDwjdg@mail.gmail.com>
Message-ID: <20171110113623.6jjl6jvnnzu4y5pi@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 07, 2017 at 10:54:17AM +0100, Geert Uytterhoeven wrote:
> On Wed, Nov 1, 2017 at 11:34 AM, Simon Horman
> <horms+renesas@verge.net.au> wrote:
> > From: Magnus Damm <damm+renesas@opensource.se>
> >
> > Add r8a7796 IPMMU nodes and keep all disabled by default.
> >
> > Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> > [simon: update names]
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> My comments for r8a7795.dtsi about IPMMU-* comments and power-domains
> properties are applicable here, too.

Thanks, will fix.
