From: dwalker@fifo99.com (Daniel Walker)
Date: Wed, 11 Apr 2012 11:07:55 -0700
Subject: [PATCH] ARM: msm: remove unused MSM boards
In-Reply-To: <20120411180408.GA12930@codeaurora.org>
References: <1334165870-12487-1-git-send-email-davidb@codeaurora.org>
 <20120411175550.GB8114@fifo99.com>
 <20120411180408.GA12930@codeaurora.org>
Message-ID: <20120411180754.GD8114@fifo99.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 11, 2012 at 11:04:09AM -0700, David Brown wrote:
> On Wed, Apr 11, 2012 at 10:55:50AM -0700, Daniel Walker wrote:
> > On Wed, Apr 11, 2012 at 10:37:50AM -0700, David Brown wrote:
> > > The "mahimahi" and "sapphire" were never finished, and have never been
> > > built.
> > > 
> > > The "halibut" target was a dev board that hasn't ever been widely
> > > available (MSM7201 "SURF").
> > 
> > I don't mind if you remove halibut, but the others are just incomplete
> > phone support which someone may want to add to.. I'd prefer to fix those
> > two..
> 
> Why, though?  It's obvious that nobody is using them, since they've
> never worked.

Didn't I submit patches to make mahimahi build, and boot? So someone has
at least used mahimahi ..

Daniel
