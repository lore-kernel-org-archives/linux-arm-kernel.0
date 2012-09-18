From: tony@atomide.com (Tony Lindgren)
Date: Mon, 17 Sep 2012 19:30:12 -0700
Subject: [PATCH] mfd: Fix compile for twl-core.c by removing
 cpu_is_omap usage
In-Reply-To: <20120917222635.GI11762@atomide.com>
References: <20120917202943.GV4521@atomide.com>
 <alpine.DEB.2.00.1209172207480.16117@utopia.booyaka.com>
 <20120917221406.GG11762@atomide.com>
 <alpine.DEB.2.00.1209172222570.18885@utopia.booyaka.com>
 <20120917222635.GI11762@atomide.com>
Message-ID: <20120918023011.GO11762@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [120917 15:27]:
> * Paul Walmsley <paul@pwsan.com> [120917 15:25]:
> > On Mon, 17 Sep 2012, Tony Lindgren wrote:
> > 
> > > We need to queue this ASAP and before other patches to fix the
> > > build breakage in linux next. Then you can merge in that commit
> > > too, does that work for you?
> > 
> > That's fine, we'll just need a stable commit then that the CCF patches can 
> > be based on.
> 
> OK cool, will let you know that once we hear from Samuel. Care to
> ack the clock related changes?
> 
> There's pm24xx.c at least using osc_ck naming, so I added a new
> alias to keep it generic for the driver instead of using omap
> specific names.

Pushed out now with the ack from Samuel and sent the pull request.

Regards,

Tony
