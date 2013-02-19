From: mturquette@linaro.org (Mike Turquette)
Date: Tue, 19 Feb 2013 10:50:34 -0800
Subject: [PATCH v7 00/12] Tegra114 clockframework
In-Reply-To: <5123C6E7.9070407@wwwdotorg.org>
References: <1360931849-7090-1-git-send-email-pdeschrijver@nvidia.com>
 <5123C6E7.9070407@wwwdotorg.org>
Message-ID: <20130219185034.27993.86892@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Stephen Warren (2013-02-19 10:39:35)
> On 02/15/2013 05:36 AM, Peter De Schrijver wrote:
> > This is the seventh version of the Tegra114 clockframework. It is based on the
> > for-next branch of
> > git://git.kernel.org/pub/scm/linux/kernel/git/swarren/linux-tegra.git and
> > http://www.spinics.net/lists/arm-kernel/msg220452.html.
> 
> Mike,
> 
> I think it'd be prudent to take this series through the Tegra tree again
> for 3.10; patch 11 needs to go in as part of the series due to internal
> dependencies, and I'm slightly worried that other Tegra DT changes might
> conflict with that patch (if only for context). Taking this series (and
> any other Tegra clk driver changes for 3.10) through the Tegra tree
> could resolve that easily. Do you have a problem with that?
> 

I was thinking the same thing.  I'll make time to review these now that
3.8 is out.

> If that's OK, can you stage the dependency Peter mentioned:
> http://www.spinics.net/lists/arm-kernel/msg220452.html
> into a stable branch for me to merge, obviously after 3.9-rc1 is out.
> 

I'll take another look at that one.  I haven't merged it yet for some
reason but I've forgotten why.  Assuming nothing is wrong then I'll pull
it in towards 3.10.

Regards,
Mike

> Thanks.
> 
> Prashant, could you provide a review/ack for this series too.
