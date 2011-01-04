From: tony@atomide.com (Tony Lindgren)
Date: Tue, 4 Jan 2011 11:17:33 -0800
Subject: [PATCH] omap: boards w/ wl12xx should select
	REGULATOR_FIXED_VOLTAGE
In-Reply-To: <AANLkTinc1xopSYvaJmN_hHaQq1TP=i_HNy5vX_LhdQOh@mail.gmail.com>
References: <1290593090-6288-1-git-send-email-ohad@wizery.com>
	<AANLkTinc1xopSYvaJmN_hHaQq1TP=i_HNy5vX_LhdQOh@mail.gmail.com>
Message-ID: <20110104191732.GI7771@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Ohad Ben-Cohen <ohad@wizery.com> [110104 10:04]:
> On Wed, Nov 24, 2010 at 12:04 PM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> > Power to the wl12xx wlan device is controlled by a fixed regulator.
> >
> > Boards that have the wl12xx should select REGULATOR_FIXED_VOLTAGE so
> > users will not be baffled.
> >
> > Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
> > ---
> 
> Hi Tony,
> 
> Gentle reminder,

This is queued for 2.6.38 in omap-for-linus as commit
7c50152f0851e44ef7491546a29fddbbea47735b?

Tony
