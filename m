From: horms@verge.net.au (Simon Horman)
Date: Thu, 17 Mar 2016 11:14:05 +0900
Subject: [PATCH] ARM: dts: lager: use generic pinctrl properties
In-Reply-To: <CAMuHMdWqTCTF-Oy8iGME8JZsjt+GJMN87_XEH3Uhtxa-ymH2KQ@mail.gmail.com>
References: <1458090189-25803-1-git-send-email-horms+renesas@verge.net.au>
 <CAMuHMdWqTCTF-Oy8iGME8JZsjt+GJMN87_XEH3Uhtxa-ymH2KQ@mail.gmail.com>
Message-ID: <20160317021404.GH17728@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 16, 2016 at 09:56:24AM +0100, Geert Uytterhoeven wrote:
> On Wed, Mar 16, 2016 at 2:03 AM, Simon Horman
> <horms+renesas@verge.net.au> wrote:
> > Since 16ccaf5bb5a5 ("pinctrl: sh-pfc: Accept standard function, pins and
> > groups properties") renesas pfc drivers accept generic "function", "pins"
> > and "groups" properties.
> >
> > This patch updates the lager device tree to use the generic
> > rather than renesas-specific properties.
> >
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> 
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, I have queued this up as a cleanup for v4.7.
