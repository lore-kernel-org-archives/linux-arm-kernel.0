From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 29 Feb 2012 16:43:05 +0100
Subject: [PATCH 3/6] ux500: select MFD_SUPPORT when needed
In-Reply-To: <201202260933.27809.arnd@arndb.de>
References: <1330199707-5179-1-git-send-email-mathieu.poirier@linaro.org>
 <1330199707-5179-3-git-send-email-mathieu.poirier@linaro.org>
 <201202260933.27809.arnd@arndb.de>
Message-ID: <CACRpkdYUqFZ_GznimZNid4wuQjAKDMVS5HspBmhAi4aLM3f6hA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 26, 2012 at 10:33 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Saturday 25 February 2012, mathieu.poirier at linaro.org wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>>
>> When the MFD_DBx500_PRCMU driver is selected, we
>> also need to select MFD_SUPPORT to guarantee a
>> successful build.
>>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
>
> This one has actually become obsolete now, the MFD_SUPPORT
> option was recently removed.

OK skipping this and trying to apply the rest...

Thanks,
Linus Walleij
