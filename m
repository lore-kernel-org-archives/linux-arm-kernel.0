From: naveenkrishna.ch@gmail.com (Naveen Krishna Ch)
Date: Mon, 28 Apr 2014 12:05:02 +0530
Subject: [PATCH 2/2 v4] i2c: exynos5: configure fifo_depth based on HSI2C
 module variant
In-Reply-To: <20140312192037.GC28891@katana>
References: <1385100851-32254-1-git-send-email-ch.naveen@samsung.com>
 <1391748195-12490-1-git-send-email-ch.naveen@samsung.com>
 <20140312192037.GC28891@katana>
Message-ID: <CAHfPSqCg-BqezXCTfDjtKwvaD3G8Ej79OCFKAfshfO0uZvyewg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Wolfram,

On 13 March 2014 00:50, Wolfram Sang <wsa@the-dreams.de> wrote:
> On Fri, Feb 07, 2014 at 10:13:15AM +0530, Naveen Krishna Chatradhi wrote:
>> fifo_depth of the HSI2C is not constant
>> Exynos5420 and Exynos5250 supports fifo_depth of 64bytes
>> Exynos5260 supports fifo_depth of 16bytes.
>>
>> This patch configures the fifo_depth based on HSI2C modules version.
>>
>> Signed-off-by: Naveen Krishna Chatradhi <ich.naveen@samsung.com>
>> [For finding out the difference and initial contribution]
>> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
>
> I know Tomasz said differently, but I prefer the patches squashed (and
> the commit message extended).
Please accept my apologies for coming back late on this CL.
Will squash and fix the compilation error and submit.

Thanks,
>



-- 
Shine bright,
(: Nav :)
