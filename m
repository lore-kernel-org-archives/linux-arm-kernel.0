From: tony@atomide.com (Tony Lindgren)
Date: Tue, 30 Nov 2010 14:23:29 -0800
Subject: [PATCH v2 1/4] drivers: hwspinlock: add generic framework
In-Reply-To: <AANLkTi=73VQeBj_M_PJO5OzJJDgWOXHkw31tN4z-nqMu@mail.gmail.com>
References: <1290526740-27624-1-git-send-email-ohad@wizery.com>
	<1290526740-27624-2-git-send-email-ohad@wizery.com>
	<20101130190058.GX17222@atomide.com>
	<AANLkTi=73VQeBj_M_PJO5OzJJDgWOXHkw31tN4z-nqMu@mail.gmail.com>
Message-ID: <20101130222328.GB17222@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Ohad Ben-Cohen <ohad@wizery.com> [101130 14:10]:
> On Tue, Nov 30, 2010 at 11:00 AM, Tony Lindgren <tony@atomide.com> wrote:
> > Do we even need the hwspin_lock variants,
> 
> I personally don't have any specific use case in mind.
> 
> It's just a simple wrapper over the _timeout variants, provided for
> API completeness, but -
> 
> > why can't we always use the hwspin_lock_timeout variants?
> 
> We can. I can just remove the _lock variants.

OK sounds good to me.

Tony
