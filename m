From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Thu, 27 Nov 2014 08:19:11 +0530
Subject: [PATCH v6 1/2] i2c: s3c2410: add Sysreg phandle to i2c device
 nodes
In-Reply-To: <54761F38.4030102@kernel.org>
References: <1416818867-29156-1-git-send-email-pankaj.dubey@samsung.com>
 <1416818867-29156-2-git-send-email-pankaj.dubey@samsung.com>
 <54761F38.4030102@kernel.org>
Message-ID: <54769127.3020102@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 27 November 2014 12:13 AM, Kukjin Kim wrote:
> On 11/24/14 17:47, Pankaj Dubey wrote:
>> This patch adds syscon based phandle to i2c device nodes of exynos5250
>> and exynos5420. These phandles will be used to save restore i2c sysreg
>> configuration register during s2r from i2c driver.
>>
>> CC: Rob Herring <robh+dt@kernel.org>
>> CC: Randy Dunlap <rdunlap@infradead.org>
>> CC: Russell King <linux@arm.linux.org.uk>
>> CC: devicetree at vger.kernel.org
>> CC: linux-doc at vger.kernel.org
>> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
>
> Applied with change the subject 'ARM: dts: add sysreg phandle to...'
>

Thanks for correcting subject message.

> BTW I'm holding on 2nd because conflicts between pm update and cleanup
> branches in my tree...

Please let me know if anything to be done from my end.

Thanks,
Pankaj Dubey
>
> - Kukjin
