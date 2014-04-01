From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Tue, 01 Apr 2014 15:22:52 +0100
Subject: [GIT PULL v2] ARM: probes: big-endian support
In-Reply-To: <533AC981.6070101@linaro.org>
References: <533AC981.6070101@linaro.org>
Message-ID: <533ACBBC.2080907@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/04/14 15:13, Taras Kondratiuk wrote:
> Hi Russell,
>
> Please pull fixes for ARM kprobes/uprobes big-endian support.
>
> It is reworked initial Ben's series for big endian support [1].
> Dropped patches that are not directly related to probes and rebased
> series on top of Dave Long's ARM uprobes series. Current set of
> patches is enough to have functional BE kprobes and uprobes.
>
> One ARM kprobe test fails on Cortex-A15 boards (TC2 and Keystone2 EVM),
> while it passes on Pandaboard. The issue is not related to this series
> and already present since v3.13-rc7.

Thanks for sorting this out.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
