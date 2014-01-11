From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Sat, 11 Jan 2014 13:28:47 +0000
Subject: [PATCH v2 0/5] ARM: kprobes: big endian support
In-Reply-To: <1389376706-30051-1-git-send-email-taras.kondratiuk@linaro.org>
References: <1389376706-30051-1-git-send-email-taras.kondratiuk@linaro.org>
Message-ID: <52D1470F.6000409@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/01/14 17:58, Taras Kondratiuk wrote:
> Reworked initial Ben's series for big endian support [1].
> Dropped patches that are not directly related to kprobes.
> Current set of patches is enough to have functional BE kprobes.
>
> One ARM kprobe test fails on Cortex-A15 boards (TC2 and Keystone2 EVM),
> while it passes on Pandaboard. The issue is not related to this series
> and already present in v3.13-rc7. I'll try to look into it later.

Thankyou for sorting this out, +1 for this set from me.


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
