From: horms@verge.net.au (Simon Horman)
Date: Thu, 30 Apr 2015 09:13:34 +0900
Subject: [PATCH 08/10] ARM: shmobile: armadillo800eva dts: Use generic
 names for device nodes
In-Reply-To: <20150430001254.GB17758@verge.net.au>
References: <1430139334-15272-1-git-send-email-geert+renesas@glider.be>
 <1430139334-15272-9-git-send-email-geert+renesas@glider.be>
 <553E3404.6020601@cogentembedded.com>
 <CAMuHMdVBCS66UCjZwRSdcWjgukoVK-JMq2ZFHX0WKkh=Jh+yBQ@mail.gmail.com>
 <20150430001254.GB17758@verge.net.au>
Message-ID: <20150430001333.GC17758@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 30, 2015 at 09:12:55AM +0900, Simon Horman wrote:
> On Tue, Apr 28, 2015 at 10:52:37AM +0200, Geert Uytterhoeven wrote:
> > On Mon, Apr 27, 2015 at 3:05 PM, Sergei Shtylyov
> > <sergei.shtylyov@cogentembedded.com> wrote:
> > >> -       wm8978: wm8978 at 1a {
> > >> +       wm8978: codec at 1a {
> > >
> > >     Perhaps sound-codec?
> > 
> > Given there's no single instance of "sound-codec" under
> > Documentation/devicetree/, and only four occurrences in DTS files (whoops,
> > I should fix up 3 of them ;-):
> 
> :)
> 
> I'm happy to help with that if you are dunning short of cycles.

I see you have already sent patches, thanks.

> >     arch/arm/boot/dts/r8a7778-bockw.dts: ak4643: sound-codec at 12 {
> >     arch/arm/boot/dts/r8a7790-lager.dts: ak4643: sound-codec at 12 {
> >     arch/arm/boot/dts/r8a7791-koelsch.dts: ak4643: sound-codec at 12 {
> >     arch/xtensa/boot/dts/xtfpga.dtsi: tlv320aic23: sound-codec at 0 {
> > 
> > I'm strongly leaning towards "codec".
> 
> On the strength of that I have queued this up.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
