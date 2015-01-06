From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 6 Jan 2015 19:09:16 +0800
Subject: [PATCH] ARM: dts: imx6dl-udoo: Add board support based off
 imx6q-udoo
In-Reply-To: <CAOCHtYgr3uXkmZgBmmy_KDQxjCrnbE5WyR5d+ONRXJABj=xNUg@mail.gmail.com>
References: <1419269361-6095-1-git-send-email-robertcnelson@gmail.com>
 <CAOMZO5ByFrTFoPUeRPBYxjB74Xn1BPQXzDxSaa+SiW_Ks5JZOw@mail.gmail.com>
 <CAOCHtYgr3uXkmZgBmmy_KDQxjCrnbE5WyR5d+ONRXJABj=xNUg@mail.gmail.com>
Message-ID: <20150106110913.GJ24511@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 22, 2014 at 11:48:19AM -0600, Robert Nelson wrote:
> On Mon, Dec 22, 2014 at 11:41 AM, Fabio Estevam <festevam@gmail.com> wrote:
> > On Mon, Dec 22, 2014 at 3:29 PM, Robert Nelson <robertcnelson@gmail.com> wrote:
> >
> >> +/dts-v1/;
> >> +#include "imx6dl.dtsi"
> >> +#include "imx6qdl-udoo.dtsi"
> >> +
> >> +/ {
> >> +       model = "Udoo i.MX6 Dual Board";
> >
> > It would be better to use "Udoo i.MX6 Dual-lite Board" in order to
> > avoid confusion with the i.MX6 Dual variant.
> >
> > Other than that:
> >
> > Reviewed-by: Fabio Estevam <fabio.estevam@freescale.com>
> 
> True! That would correctly match the other dual-lite boards on mainline too.
> 
> Shawn, if you want me to respin the patch i will, otherwise can you
> tweak that line?

Fixed it up and applied.
