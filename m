From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Mon, 26 May 2014 13:47:44 +0200
Subject: [RFC PATCH 2/5] clk: Introduce 'clk_round_rate_nearest()'
In-Reply-To: <CAKohpomam0qKdkMMMRDOfWN9QnZ3DzCviV=RuZ5f_7JbmYNDNw@mail.gmail.com>
References: <20140521073457.GD31687@pengutronix.de>
 <9956925.Qsz2bH3rDg@vostro.rjw.lan>
 <CAKohpomam0qKdkMMMRDOfWN9QnZ3DzCviV=RuZ5f_7JbmYNDNw@mail.gmail.com>
Message-ID: <9956935.0oj56vcaUh@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, May 26, 2014 04:37:13 PM Viresh Kumar wrote:
> On 26 May 2014 16:52, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > I agree as far as the 64-bit thing goes, but is switching to Hz really
> > necessary?
> 
> Don't really know that.. It seems that there will always be problems with
> close enough frequencies whenever rounding is done.

Well, rounding errors are a problem, but question is if that is enough of
a problem to justify expanding the storage size twice.  Also, that'd be
a performance hit on 32-bit systems.

> More can be elaborated by Soren.

OK

Rafael
