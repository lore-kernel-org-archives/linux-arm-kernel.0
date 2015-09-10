From: timur@codeaurora.org (Timur Tabi)
Date: Thu, 10 Sep 2015 11:58:43 -0500
Subject: [GIT PULL] arm64: updates for 4.3
In-Reply-To: <20150904102656.GC4818@arm.com>
References: <20150904102656.GC4818@arm.com>
Message-ID: <CAOZdJXX_avYXi9JSk=Ge6fuBLzS1n2jd7yBmhnFx4u_ptvNS5A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 4, 2015 at 5:26 AM, Will Deacon <will.deacon@arm.com> wrote:
>
>   * Hide direct DCC access from userspace

Doesn't this make sense only if DCC is enabled for ARM64?  These
patches are not part of your patchset:

[v5] ARM64: TTY: hvc_dcc: Add support for ARM64 dcc
[v3] hvc_dcc: don't ignore errors during initialization

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
