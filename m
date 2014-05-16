From: alex.shi@linaro.org (Alex Shi)
Date: Fri, 16 May 2014 08:33:35 +0800
Subject: [PATCH] ARM: OMAP4: Fix the boot regression with CPU_IDLE enabled
In-Reply-To: <5375079E.3060305@ti.com>
References: <1399991966-14582-1-git-send-email-santosh.shilimkar@ti.com>
 <5373C78E.7040301@linaro.org> <5373C8E8.6040208@ti.com>
 <5373CBB9.40506@linaro.org> <5373DD94.8030208@ti.com>
 <5374F35E.5040900@ti.com> <5374FE61.50901@linaro.org>
 <5374FF5B.8050702@ti.com> <5375079E.3060305@ti.com>
Message-ID: <53755CDF.9030803@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/16/2014 02:29 AM, Santosh Shilimkar wrote:
> Alex,
> Please give a try with your test-case and see if you still see the hang.
> Am just curious about your issue and hence the request..

there is no test case. I just patched your patches, then boot new
kernel, system quickly to hang without any serial port oops, I am using
pandaES/ubuntu.

-- 
Thanks
    Alex
