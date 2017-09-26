From: will.deacon@arm.com (Will Deacon)
Date: Tue, 26 Sep 2017 13:45:37 +0100
Subject: Unreviewed arm64 ABI change in linux-next via driver-core tree
Message-ID: <20170926124536.GA11192@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg,

We stumbled over a change in linux-next that has ABI implications for arm64
and, as far as we can tell, has not been reviewed:

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/arch/arm64/kernel?id=fb7ff3f8721b87bf078868c9a252fa0cf71a47c2

("fb7ff3f8721b cpuinfo: implement sysfs nodes for arm64")

It looks like this was requested by you on LKML here:

https://lkml.org/lkml/2017/8/2/663

but these sorts of changes really need to go on the linux-arm-kernel mailing
list with the maintainers on cc so that the patches can be properly reviewed
and eventually acked if appropriate. In this case, I can't find any trace of
the patch on any of the mailing lists to which I'm subscribed.

Please can you drop this from your tree until we've had a chance to review
it properly? If Felix can repost it as above, then we can get the discussion
started because, aside from this email, we have concerns about exactly what
is being exposed to userspace here.

Thanks,

Will
