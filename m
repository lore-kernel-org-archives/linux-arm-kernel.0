From: shijie.huang@arm.com (Huang Shijie)
Date: Tue, 28 Jun 2016 16:13:44 +0800
Subject: [PATCH v14 00/10] arm64: Add kernel probes (kprobes) support
In-Reply-To: <1466996813-23295-1-git-send-email-dave.long@linaro.org>
References: <1466996813-23295-1-git-send-email-dave.long@linaro.org>
Message-ID: <20160628081342.GA2053@sha-win-210.asiapac.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 26, 2016 at 11:06:43PM -0400, David Long wrote:
> From: "David A. Long" <dave.long@linaro.org>
> 
> This patchset is heavily based on Sandeepa Prabhu's ARM v8 kprobes patches,
> first seen in October 2013. This version attempts to address concerns
> raised by reviewers and also fixes problems discovered during testing.
> 
> This patchset adds support for kernel probes(kprobes), jump probes(jprobes)
> and return probes(kretprobes) support for ARM64.
> 
> The kprobes mechanism makes use of software breakpoint and single stepping
> support available in the ARM v8 kernel.
> 
I tested the whole patch set with kprobe/jprobe/kretprobe in my Juno-r1 board,
it works fine.

Tested-by: Huang Shijie <shijie.huang@arm.com>

thanks
Huang Shijie
