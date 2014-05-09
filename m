From: alex.bennee@linaro.org (Alex =?utf-8?Q?Benn=C3=A9e?=)
Date: Fri, 09 May 2014 16:29:22 +0100
Subject: [PATCH 2/5] arm64: dts: APM X-Gene SoC Ethernet device tree nodes
In-Reply-To: <CAKh23FmGYGkCbeh4DbL4_NO6ypkw4F70J0X__KxFyHTo-=WtKg@mail.gmail.com>
References: <1387597376-29303-1-git-send-email-isubramanian@apm.com>
 <1387597376-29303-3-git-send-email-isubramanian@apm.com>
 <1390582906.12454.26.camel@deneb.redhat.com>
 <CAKh23FmGYGkCbeh4DbL4_NO6ypkw4F70J0X__KxFyHTo-=WtKg@mail.gmail.com>
Message-ID: <87ppjnc6nh.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Iyappan Subramanian <isubramanian@apm.com> writes:

> Hi Mark,
>
> Thanks for the review comment and I apologize for not replying sooner.
>
> We are completely redesigning the ethernet driver to make it simple
> and cleaner and will be posted shortly.

Hi Iyappan,

Did this ever get posted? I'm trying to get a close-to-HEAD kernel up
and running on our APM hardware but have run afoul of the differences
between the latest XGENE_MBOX patch set and the older NET_XGENE patch
set.

If it's not long away then I shall wait a bit otherwise I'll see if the
missing bits can be forward ported from our working
3.8.0-mustang_sw_1.08.12-beta_rc.jcm15 kernel (purely for testing
purposes).

Do you have a public tree where your latest kernels are visible?

Cheers,

--
Alex Benn?e
QEMU/KVM Hacker for Linaro
