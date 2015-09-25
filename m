From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Fri, 25 Sep 2015 22:26:22 +0200
Subject: [PATCH V4 1/2] ACPI / EC: Fix broken 64bit big-endian users of
 'global_lock'
In-Reply-To: <20150925185256.GG5951@linux>
References: <e28c4b4deaf766910c366ab87b64325da59c8ad6.1443198783.git.viresh.kumar@linaro.org>
 <1443206945.2161.9.camel@sipsolutions.net> <20150925185256.GG5951@linux>
Message-ID: <4331507.W3ZDWldbWu@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, September 25, 2015 11:52:56 AM Viresh Kumar wrote:
> On 25-09-15, 20:49, Johannes Berg wrote:
> > Ok, then, but that means Rafael is completely wrong ...
> > debugfs_create_bool() takes a *pointer* and it needs to be long-lived,
> > it can't be on the stack. You also don't get a call when it changes.
> 
> Ahh, ofcourse. My bad as well...

Well, sorry about the wrong suggestion.

> I think we can change structure definition but will wait for Rafael's
> comment before that.

OK, change the structure then.

Thanks,
Rafael
