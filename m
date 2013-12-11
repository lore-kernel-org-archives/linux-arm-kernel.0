From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 11 Dec 2013 04:45:54 +0100
Subject: [PATCH 2/2] mmc: dw_mmc: add dw_mmc-k3 for k3 platform
In-Reply-To: <CAMj5BkhyiJ7Uc-GiRZP3TNMq3NvHW-MVuPT6t+7FN8KBWAJR5A@mail.gmail.com>
References: <1383889128-12540-1-git-send-email-zhangfei.gao@linaro.org>
 <201312060239.14832.arnd@arndb.de>
 <CAMj5BkhyiJ7Uc-GiRZP3TNMq3NvHW-MVuPT6t+7FN8KBWAJR5A@mail.gmail.com>
Message-ID: <201312110445.54336.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 11 December 2013, Zhangfei Gao wrote:
> Thanks for the good suggestion, it can be abstracted to clock.
> 
> The issue for this version's ip is there are some registers need to be
> set, including fixed factor and phase, which may be required to be
> tuned, however it can be hide in clock.
> 
> Double checked next version's ip, it is more intelligent and only
> fixed factor is required, more like a clock, and all these register
> accessing are NOT required.
> 
> Will update new version to abstract these chip depended registers to clock.

Ok, please stay in contact with Dinh Nguyen over this, since his side
is work-in-progress and we are still evaluating how to best encode
the phase setting in DT in a generic form.

	Arnd
