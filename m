From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed, 12 Aug 2015 22:39:47 +0900
Subject: [PATCH v2 0/4] Device Tree updates of UniPhier SoCs for Linux 4.3
In-Reply-To: <20150811132049.GK30181@localhost>
References: <1438857468-9740-1-git-send-email-yamada.masahiro@socionext.com>
 <20150811132049.GK30181@localhost>
Message-ID: <CAK7LNAS_Tx=-it9LFg1K7i-URu1Dx_2xnHPkgM1KJkBFb9q4ig@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-08-11 22:20 GMT+09:00 Olof Johansson <olof@lixom.net>:
> On Thu, Aug 06, 2015 at 07:37:44PM +0900, Masahiro Yamada wrote:
>> Hi Olof and Arnd,
>>
>> Here are a little more updates for device trees for UniPhier SoCs.
>>
>> Please consider applying this series to your ARM-SOC tree.
>>
>> Thanks!
>
> Hi,
>
> Please always comment on when the previous when you respin. I didn't
> see this thread until after I had applied v1.
>
> I've taken 2/4 directly now, since it's the only difference.


Instead, build fails between commit a5e921b4771 and 63ef577d9
because 2/4 is a pre-requisite patch for 3/4 and /4/4.


Maybe I should have sent a pull-request instead of patches.





-- 
Best Regards
Masahiro Yamada
