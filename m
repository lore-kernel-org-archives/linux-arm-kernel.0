From: cov@codeaurora.org (Christopher Covington)
Date: Thu, 28 Apr 2016 11:18:52 -0400
Subject: VDSO unmap and remap support for additional architectures
In-Reply-To: <20151202121918.GA4523@arm.com>
References: <20151202121918.GA4523@arm.com>
Message-ID: <1461856737-17071-1-git-send-email-cov@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Please take a look at the following prototype of sharing the PowerPC
VDSO unmap and remap code with other architectures. I've only hooked
up arm64 to begin with. If folks think this is a reasonable approach I
can work on 32 bit ARM as well. Not hearing back from an earlier
request for guidance [1], I simply dove in and started hacking.
Laurent's test case [2][3] is a compelling illustration of whether VDSO
remap works or not on a given architecture.

1. https://lkml.org/lkml/2016/3/2/225
2. https://lists.openvz.org/pipermail/criu/2015-March/019161.html
3. http://lists.openvz.org/pipermail/criu/attachments/20150318/f02ed9ea/attachment.bin

Thanks,
Christopher Covington
