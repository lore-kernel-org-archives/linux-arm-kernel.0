From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Mon, 4 Sep 2017 11:38:19 +0200
Subject: [PATCH V3 1/8] drivers: Add boot constraints core
In-Reply-To: <20170904091522.GA2816@ubuntu>
References: <cover.1501578037.git.viresh.kumar@linaro.org>
 <1a844e27ee7e0b22acf8ea582bf4e8d35f54c84a.1501578037.git.viresh.kumar@linaro.org>
 <20170829063923.GD12198@kroah.com> <20170829095217.GA3101@ubuntu>
 <20170829120343.GA4321@kroah.com> <20170904091522.GA2816@ubuntu>
Message-ID: <20170904093819.GA28202@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 04, 2017 at 11:15:47AM +0200, Viresh Kumar wrote:
> On 29-08-17, 14:03, Greg Kroah-Hartman wrote:
> > Who couldn't reach an agreement?
> 
> Rob Herring (DT Maintainer) didn't like the first set of bindings and wasn't
> convinced that we need any new bindings for this purpose to begin with.

So Rob wanted more kernel code and less bindings?
Ok, I'll ask for Rob to sign off on these patches then :)

> > But you are implying that existing handheld devices need this problem
> > solved, how do they do it today without this code as obviously they are
> > shipping working solutions.
> 
> So yeah, LCD is a common usecase but the configurations aren't always shared. It
> may not be an issue with private clock/regulator resources, but with shared
> ones.
> 
> Though even with the private resources, we may want the clock/domains/regulators
> to stay powered on and I assume that the platforms would be doing hacky stuff to
> get that all working right now.

As you have the source for a number of such systems, you might want to
verify this please.  Also, what is going to cause any new systems to use
this new api?

thanks,

greg k-h
