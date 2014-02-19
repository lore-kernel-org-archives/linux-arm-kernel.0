From: taras.kondratiuk@linaro.org (Taras Kondratiuk)
Date: Thu, 20 Feb 2014 00:59:53 +0200
Subject: [GIT PULL] ARM: kprobes: big-endian support
In-Reply-To: <52D3D784.2000600@linaro.org>
References: <52D3D784.2000600@linaro.org>
Message-ID: <53053769.5090100@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/13/2014 02:09 PM, Taras Kondratiuk wrote:
> Hi Russell,
> 
> Please pull fixes for ARM Kprobes big-endian support.
> 
> It is reworked initial Ben's series for big endian support [1].
> Dropped patches that are not directly related to kprobes.
> Current set of patches is enough to have functional BE kprobes.
> 
> One ARM kprobe test fails on Cortex-A15 boards (TC2 and Keystone2 EVM),
> while it passes on Pandaboard. The issue is not related to this series
> and already present in v3.13-rc7.
> 
> [1] http://www.spinics.net/lists/arm-kernel/msg285210.html
> 

Hi Russell,

This pull request is based on 3.13-rc8, but it applies cleanly to
3.14-rc3, because kprobes are not touched since then.
Do I need to resent a new pull request based on 3.14-rc3 anyway?

-- 
Taras Kondratiuk
