From: sameo@linux.intel.com (Samuel Ortiz)
Date: Mon, 30 Jul 2012 15:24:22 +0200
Subject: [PATCH 4/7] mfd: ab8500-core: Apply the AB8500 CODEC's
 compatible string to its MFD cell
In-Reply-To: <20120729202806.GC4384@opensource.wolfsonmicro.com>
References: <1343392734-11805-1-git-send-email-lee.jones@linaro.org>
 <1343392734-11805-5-git-send-email-lee.jones@linaro.org>
 <20120727133633.GQ16859@sortiz-mobl>
 <20120729202806.GC4384@opensource.wolfsonmicro.com>
Message-ID: <20120730132422.GW16859@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 29, 2012 at 09:28:07PM +0100, Mark Brown wrote:
> On Fri, Jul 27, 2012 at 03:36:33PM +0200, Samuel Ortiz wrote:
> > On Fri, Jul 27, 2012 at 01:38:51PM +0100, Lee Jones wrote:
> 
> > > Provide a compatible string for the AB8500 CODEC to aid in
> > > configuration property look-up from its associated Device Tree
> > > node.
> 
> > Applied as well.
> 
> I remain *deeply* unconvinced that this is tasteful design for the
> device tree bindings, and it's certainly not needed urgently for v3.6 as
> there's no DT bindings on the CODEC side.
Fair enough, I'll keep this one for the next merge window.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
