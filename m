From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 29 Aug 2012 13:14:51 -0400
Subject: [RFC PATCH] ARM: initial DTS support for km_kirkwood
In-Reply-To: <503DCFB7.4080804@keymile.com>
References: <1346154976-16916-1-git-send-email-valentin.longchamp@keymile.com>
 <20120828172344.GE19437@titan.lakedaemon.net>
 <503DCFB7.4080804@keymile.com>
Message-ID: <20120829171451.GP19437@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 29, 2012 at 10:15:51AM +0200, Valentin Longchamp wrote:
> On 08/28/2012 07:23 PM, Jason Cooper wrote:
> > On Tue, Aug 28, 2012 at 01:56:16PM +0200, Valentin Longchamp wrote:
> >> +	ocp at f1000000 {
> >> +		serial at 12000 {
> >> +			clock-frequency = <200000000>;
> >> +			status = "ok";
> >> +		};
> >> +
> >> +		nand at 3000000 {
> >> +			status = "ok";
> >> +			chip-delay = <25>;
> >> +		};
> > 
> > Is there a partition layout for this board?
> 
> Well, there is one: one big UBI partition on the whole NAND chip (we then create
> UBI volumes when building the initial system and dynamically create additional
> ones when neeeded). But this UBI partition gets detected perfecly well without
> this partition layout so I left it out.

ok, just wanted to make sure it wasn't left out.  I look forward to v2
with Andrew's suggestions.

thx,

Jason.
