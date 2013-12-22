From: olof@lixom.net (Olof Johansson)
Date: Sun, 22 Dec 2013 12:10:37 -0800
Subject: [GIT PULL v2] ARM: Initial support for Marvell Berlin SoCs
In-Reply-To: <87pposk89r.fsf@linaro.org>
References: <1387202444-7270-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1387357681-30730-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <87pposk89r.fsf@linaro.org>
Message-ID: <CAOesGMgPpdB=EKos5-uCmERKdnTq4BXKYNFqgQb9n-oLmMdHRw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 19, 2013 at 10:25 AM, Kevin Hilman <khilman@linaro.org> wrote:
> Hi Sebastian,
>
> Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com> writes:
>
>> Dear ARM maintainers,
>>
>> please pull the initial support patches for Marvell Berlin SoCs.
>> While this is the initial PR, it is not yet split up into the
>> usual sub-branches. If you require it, please request it.
>
> In the future, please split things up into the usual branches.  However,
> for new SoC support like this, where it's new files being added, the
> risk of conflicts is low so I'm OK keeping it all together.
>
> In particular, normally the drivers/* stuff should go through the
> driver/subsystem maintainer, but I see that tglx reviewed this one so
> I'm assuming that means he's OK with it going through our tree along
> with the DT binding.

In particular, don't update multi_v7_defconfig in  your own branches
-- instead send patches to do it. We have plenty of conflicts on that
file since several maintainers update it and it's easier for us to do
it in one branch ourselves.


-Olof
