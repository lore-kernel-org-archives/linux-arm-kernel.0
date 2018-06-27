From: manivannan.sadhasivam@linaro.org (Manivannan Sadhasivam)
Date: Wed, 27 Jun 2018 20:40:52 +0530
Subject: [PATCH 1/4] dt-bindings: power: Add Actions Semi S900 SPS
In-Reply-To: <20180627145713.uao2gr5kknk2cypk@holly.lan>
References: <20180411164036.8046-1-manivannan.sadhasivam@linaro.org>
 <20180411164036.8046-2-manivannan.sadhasivam@linaro.org>
 <a261bae6-d2fa-a550-7232-7647ce0ac0e2@suse.de>
 <20180626164117.GA5241@Mani-XPS-13-9360>
 <20180627145713.uao2gr5kknk2cypk@holly.lan>
Message-ID: <20180627151052.GA24330@mani>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 27, 2018 at 03:57:13PM +0100, Daniel Thompson wrote:
> On Tue, Jun 26, 2018 at 10:11:17PM +0530, Manivannan Sadhasivam wrote:
> > > > diff --git a/include/dt-bindings/power/owl-s900-powergate.h b/include/dt-bindings/power/owl-s900-powergate.h
> > > > new file mode 100644
> > > > index 000000000000..f1aaf761112b
> > > > --- /dev/null
> > > > +++ b/include/dt-bindings/power/owl-s900-powergate.h
> > > > @@ -0,0 +1,23 @@
> > > > +// SPDX-License-Identifier: GPL-2.0+
> > > 
> > > checkpatch.pl warns about this line due to not using /* ... */ syntax
> > > for headers. I could fix that up on my own, but it made me realize that
> > > you are licensing this file under GPL-2.0+ only, whereas the .dts[i] is
> > > supposed to be dual-licensed.
> > > 
> > > Can you please give your consent to make this
> > > 
> > > /* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
> > > 
> > 
> > You can change the license to GPL-2.0+ OR MIT.
> > 
> > > like my S500 and S700 bindings?
> > > 
> > > Question: Should it still be GPL-2.0+ or the new GPL-2.0-or-later?
> > >
> > 
> > I think GPL-2.0+ is fine.
> 
> So... when I saw this I did wonder why one would knowly choose to use a
> deprecated license identifier (https://spdx.org/licenses/ ).
> 
> However running `git diff v4.17..v4.18-rc1` through some filters does
> indicate that GPL-2.0+ is the more popular choice by 256 to 0! Doesn't
> mean you couldn't break the mould though ;-).
>

I did grep through the source and hit with same numbers ;-) But I was not
sure whether to break the mould or not, so chose the safest path :)

Since you already gave the green signal, I think we can move to new style
identifier.

Thanks,
Mani 
> 
> Daniel.
