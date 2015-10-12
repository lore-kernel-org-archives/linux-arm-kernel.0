From: tony@atomide.com (Tony Lindgren)
Date: Mon, 12 Oct 2015 16:10:24 -0700
Subject: [PATCH] ARM: OMAP2+: PM: Denote the cpuidle tracepoints as
 _rcuidle()
In-Reply-To: <20150924111854.43429ca2@xhacker>
References: <1442554881-706-1-git-send-email-jszhang@marvell.com>
 <7hfv25dnkn.fsf@deeprootsystems.com>
 <20150923180814.GL23801@atomide.com>
 <20150924111854.43429ca2@xhacker>
Message-ID: <20151012231024.GO23801@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Jisheng Zhang <jszhang@marvell.com> [150923 20:26]:
> Dear Tony,
> 
> On Wed, 23 Sep 2015 11:08:15 -0700
> Tony Lindgren <tony@atomide.com> wrote:
> 
> > * Kevin Hilman <khilman@kernel.org> [150923 11:03]:
> > > Jisheng Zhang <jszhang@marvell.com> writes:
> > > 
> > > > The cpuidle tracepoints are called within a rcu_idle_exit() section, and
> > > > must be denoted with the _rcuidle() version of the tracepoint.
> > > >
> > > > Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> > >  
> > > Acked-by: Kevin Hilman <khilman@linaro.org>
> > 
> > Hmm is this needed as a fix for the -rc cycle or can this wait
> > for v4.4?
> 
> IMHO, this is a fix. But it can wait for v4.4 merge window.

Applying into omap-for-v4.4/fixes thanks.

Tony
