From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Mon, 08 Apr 2013 12:46:38 +0200
Subject: [PATCH 07/18] cpufreq: s3c24xx: move cpufreq driver to
 drivers/cpufreq
In-Reply-To: <2ccd01ce3439$911b51b0$b351f510$%kim@samsung.com>
References: <cover.1365079581.git.viresh.kumar@linaro.org>
 <1769336.FkfMpuXqqb@vostro.rjw.lan>
 <2ccd01ce3439$911b51b0$b351f510$%kim@samsung.com>
Message-ID: <2166815.0SZ6SYhSDN@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, April 08, 2013 06:15:09 PM Kukjin Kim wrote:
> Rafael J. Wysocki wrote:
> > 
> > On Friday, April 05, 2013 12:36:34 PM Viresh Kumar wrote:
> > > On 5 April 2013 12:18, Kukjin Kim <kgene.kim@samsung.com> wrote:
> > > > Basically, this moving looks good to me, but should be re-worked based
> > on
> > > > for-next of samsung tree because this touches too many samsung stuff
> > so this
> > > > should be sent to upstream via samsung tree.
> > >
> > > Hmm... Its already applied in Rafael's tree. But it doesn't mean that
> > > it can't be
> > > moved to your tree if there is a issue.
> > 
> > Well, I'm dropping it.  Please merge via the Samsung tree.
> > 
> OK, I will.
> 
> I got patch file from Viresh, and there is a sign from Rafael,
> but it should be ack. So Rafael, let me use your ack on this patch when
> I apply. If any problems, please let me know.

Since it was signed-off by me before, you can assume it's been ACKed as well.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
