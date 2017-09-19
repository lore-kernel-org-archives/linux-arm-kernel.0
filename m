From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 19 Sep 2017 15:46:52 -0700
Subject: [PATCH V3 1/8] drivers: Add boot constraints core
In-Reply-To: <20170904093819.GA28202@kroah.com>
References: <cover.1501578037.git.viresh.kumar@linaro.org>
 <1a844e27ee7e0b22acf8ea582bf4e8d35f54c84a.1501578037.git.viresh.kumar@linaro.org>
 <20170829063923.GD12198@kroah.com> <20170829095217.GA3101@ubuntu>
 <20170829120343.GA4321@kroah.com> <20170904091522.GA2816@ubuntu>
 <20170904093819.GA28202@kroah.com>
Message-ID: <20170919224652.GG30848@ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04-09-17, 11:38, Greg Kroah-Hartman wrote:
> On Mon, Sep 04, 2017 at 11:15:47AM +0200, Viresh Kumar wrote:
> > On 29-08-17, 14:03, Greg Kroah-Hartman wrote:
> > > Who couldn't reach an agreement?
> > 
> > Rob Herring (DT Maintainer) didn't like the first set of bindings and wasn't
> > convinced that we need any new bindings for this purpose to begin with.
> 
> So Rob wanted more kernel code and less bindings?

We had a similar thread sometime back (Performance states for power
domains), where we couldn't get to the bindings in the first go. Rob
suggested that we can actually get the code in first and then we can
look at how to get stuff from DT once we understand it more.

He wasn't happy with the bindings I proposed and so I took the same
approach here. Its not a lot of code we are going to have to remove
once we move to DT, so it ain't that bad.

> Ok, I'll ask for Rob to sign off on these patches then :)

I can't give any guarantee of that ;)

> As you have the source for a number of such systems, you might want to
> verify this please.

I will try to talk to few guys during Linaro connect next week and
also look into source for such stuff.

> Also, what is going to cause any new systems to use
> this new api?

As far as my part go, I can do my best to advertise it with articles
and presentations. But eventually people have to get motivated to use
it themselves :)

What else can I do as an author here? I will do whatever it takes to
get people to use it.

-- 
viresh
