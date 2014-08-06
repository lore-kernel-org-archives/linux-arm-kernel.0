From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Thu, 07 Aug 2014 00:50:23 +0200
Subject: [PATCH v2] cpufreq: tests: Providing cpufreq regression test
In-Reply-To: <20140724090402.1f981470@amdc2363>
References: <1405678985-21677-1-git-send-email-l.majewski@samsung.com>
 <3777635.Nvoh2EpFlu@vostro.rjw.lan> <20140724090402.1f981470@amdc2363>
Message-ID: <3078797.FIBUCqEiQa@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, July 24, 2014 09:04:02 AM Lukasz Majewski wrote:
> Hi Rafael,
> 
> > On Monday, July 21, 2014 09:02:34 AM Lukasz Majewski wrote:
> > > This commit adds first regression test "cpufreq_freq_test.sh" for
> > > the cpufreq subsystem.
> > 
> > First of all, I'm not seeing any explanation why this script should be
> > shipped with the kernel.
> 
> OK.
> 
> > 
> > What regressions it tests against in particular and 
> 
> Do you require SHA's/commit messages of commits which were developed to
> fix issues spotted with this test script?

No.  I want information about what kind of bugs can be catched with the
help of this script.

> > how it does that.
> 
> Is this information required in the commit message or can it stay in
> the README file created in the same commit?

There should be *some* information in the changelog too.

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
