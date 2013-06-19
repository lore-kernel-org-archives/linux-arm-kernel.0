From: khilman@linaro.org (Kevin Hilman)
Date: Wed, 19 Jun 2013 13:41:10 -0700
Subject: [RFC PATCH v2 0/2] ARM: MPIDR linearization
In-Reply-To: <20130611095848.GD8164@e102568-lin.cambridge.arm.com> (Lorenzo
 Pieralisi's message of "Tue, 11 Jun 2013 10:58:48 +0100")
References: <1370532125-14322-1-git-send-email-lorenzo.pieralisi@arm.com>
 <20130611095848.GD8164@e102568-lin.cambridge.arm.com>
Message-ID: <877ghp6dg9.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lorenzo,

Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> writes:

> Hi Russell, all,
>
> even though I think this set is ready to get merged, it would be great
> if we can test it on as many platforms as possible since it touches core
> suspend/resume operations on ARM platforms relying on CONFIG_ARM_CPU_SUSPEND,
> and there are many.
>
> I pushed out a branch:
>
> git://linux-arm.org/linux-2.6-lp.git mpidr-linearization
>
> if anyone has time to test the set that would be really great, thank you
> very much.

I'm a little late to the party, but I tested this on OMAP4 with the CPUs
hitting off in the lower C-states.

Tested-by: Kevin Hilman <khilman@linaro.org>

Kevin
