From: tony@atomide.com (Tony Lindgren)
Date: Thu, 21 Sep 2017 07:27:49 -0700
Subject: [PATCH 08/10] ARM: dts: Add nodes for missing omap4 interconnect
 target modules
In-Reply-To: <20170921025656.omeoippus7b4mmig@squirrel.local>
References: <20170920224621.16236-1-tony@atomide.com>
 <20170920224621.16236-9-tony@atomide.com>
 <20170921025656.omeoippus7b4mmig@squirrel.local>
Message-ID: <20170921142748.GA4394@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Matthijs van Duin <matthijsvanduin@gmail.com> [170920 19:57]:
> On Wed, Sep 20, 2017 at 03:46:19PM -0700, Tony Lindgren wrote:
> > For AESS there is old Android 3.4 kernel
> > driver available but it's unlikely that anybody is going to update
> > it for the mainline kernel.
> 
> We do actually hope to get the Audio Engine in ABE working eventually on
> omap5 (which would presumably also make it work on omap4). and there are
> more recent kernels that support it: a TI 3.8 kernel and a 3.15 branch
> from Peter Ujfalusi [1].

OK cool, so I'll drop the "but it's unlikely that anybody is going to update
it for the mainline kernel" part.

Regards,

Tony

> [1] https://pyra-handheld.com/pipermail/kernel/2017-September/002060.html
