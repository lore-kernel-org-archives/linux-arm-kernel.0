From: will.deacon@arm.com (Will Deacon)
Date: Wed, 25 Feb 2015 12:16:11 +0000
Subject: stand-alone kvmtool
In-Reply-To: <54EB622E.3020700@iki.fi>
References: <54DDD465.3050300@arm.com> <20150218155042.GF22017@arm.com>
 <54EB622E.3020700@iki.fi>
Message-ID: <20150225121610.GA12377@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 23, 2015 at 05:23:58PM +0000, Pekka Enberg wrote:
> Hi,

Hi Pekka,

Sorry for the delay, I've been away from email for a few days.

> On 2/18/15 5:50 PM, Will Deacon wrote:
> > Thanks for doing this. Since it looks unlikely that kvmtool will ever be
> > merged back into the kernel tree, it makes sense to cut the dependency
> > in my opinion.
> 
> I am certainly OK with a standalone repository which preserves the 
> history. Will, would you like to take over the proposed new repository 
> and put it somewhere on git.kernel.org, perhaps?

Sure thing. I'll sync-up with Andre and reply back here when we've got
something sensible.

One extra point that I don't think has been mentioned in this thread so
far is that separating kvmtool from the kernel sources is likely a
prerequisite for distribution packaging. Once we've got something sorted
out, I'll poke some friendly local debian developers and see if they can't
package it up for us.

Will
