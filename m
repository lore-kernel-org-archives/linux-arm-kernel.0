From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Mon, 7 Jul 2014 10:35:02 -0700
Subject: [PATCH v2 2/2] devicetree: Add Zynq GPIO devicetree bindings
 documentation
In-Reply-To: <CACRpkdYZ8gQ_-z3Ue3WZZ4FiV8dhw_BZez2-PLpeiBTs-UnNFQ@mail.gmail.com>
References: <1403091577-10232-1-git-send-email-harinik@xilinx.com>
 <1403091577-10232-2-git-send-email-harinik@xilinx.com>
 <CACRpkdYZ8gQ_-z3Ue3WZZ4FiV8dhw_BZez2-PLpeiBTs-UnNFQ@mail.gmail.com>
Message-ID: <30b61880-97a0-4e94-a71e-d738f0416d9d@BN1BFFO11FD056.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2014-07-07 at 04:53PM +0200, Linus Walleij wrote:
> On Wed, Jun 18, 2014 at 1:39 PM, Harini Katakam <harinik@xilinx.com> wrote:
> 
> > From: Harini Katakam <harini.katakam@xilinx.com>
> >
> > Add gpio-zynq bindings documentation.
> >
> > Signed-off-by: Harini Katakam <harinik@xilinx.com>
> > Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> > ---
> >
> > v2 changes:
> > Improve description.
> (...)
> > +- #gpio-cells          : Should be two. First cell is used to mention
> > +                         pin number.
> 
> Don't call this "pin number", call it "GPIO line number".
It's also not mentioning the second cell at all. I'll take the part from
gpio-msm to document this property and replace 'pin' with 'GPIO line'.

	S?ren
