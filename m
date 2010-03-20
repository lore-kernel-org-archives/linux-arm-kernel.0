From: tony@atomide.com (Tony Lindgren)
Date: Fri, 19 Mar 2010 17:47:47 -0700
Subject: [PATCH] arm: Fix DEBUG_LL for omap zoom2/3
In-Reply-To: <20100320003605.GA11448@atomide.com>
References: <20100320003605.GA11448@atomide.com>
Message-ID: <20100320004746.GB11448@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [100319 17:30]:
> Hi all,
> 
> Got a zoom3 finally! This is needed to boot with DEBUG_LL + earlyprintk.

And of course it won't compile because of a missing #.
Here's the working version.

Tony
