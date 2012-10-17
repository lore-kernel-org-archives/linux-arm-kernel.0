From: tony@atomide.com (Tony Lindgren)
Date: Tue, 16 Oct 2012 19:14:43 -0700
Subject: [PATCH] ARM: OMAP2: UART: fix console UART mismatched runtime
 PM status
In-Reply-To: <87wqyplxjo.fsf@deeprootsystems.com>
References: <1350344998-16328-1-git-send-email-khilman@deeprootsystems.com>
 <20121016102517.GD21801@arwen.pp.htv.fi>
 <20121016211828.GL15569@atomide.com>
 <87wqyplxjo.fsf@deeprootsystems.com>
Message-ID: <20121017021442.GQ15569@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Kevin Hilman <khilman@deeprootsystems.com> [121016 18:04]:
> 
> Doh, this isn't quite right yet.  Some more PM testing shows that UART
> wakeups are broken, so this isn't ready for v3.7 yet.

OK I'll drop it then.

Tony
