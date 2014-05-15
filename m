From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Thu, 15 May 2014 17:20:03 +0800
Subject: [PATCH v6 00/15] enable HiP04 SoC
In-Reply-To: <14229972.j5k474Mq5Q@wuerfel>
References: <1399795571-17231-1-git-send-email-haojian.zhuang@linaro.org>
 <14229972.j5k474Mq5Q@wuerfel>
Message-ID: <CAD6h2NSpH0zxpek4KnUMT-p_DFnGZVaxP+x_0hsn1S8O6C7X6g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15 May 2014 02:37, Arnd Bergmann <arnd@arndb.de> wrote:
> On Sunday 11 May 2014 16:05:56 Haojian Zhuang wrote:
>> Changelog:
>> v6:
>>   * Split HiP04 enabling patch into patches on document, mcpm & hiP04.
>>   * Move reset operation in HiP04 MCPM implementation.
>>   * Remove ARCH_MULTI_V7_NONLPAE & ARCH_MULTI_V7_LPAE according to olof's
>>     comment.
>
> The latest version looks good to me, at least if all the remaining
> comments for the mcpm implementation have been addressed.
>
> I would suggest to split the series into two, and submit all the gic
> related changes through Russell's patch tracker but have a pull
> request for the platform changes.
>
> As far as I can tell, there are no compile-time dependencies between
> the two, so we don't get a broken build during bisection, but
> of course the platform will only be usable if both parts are merged.
>
>         Arnd

Hi Arnd,

Thanks. I'll submit gic patches into Russell's patch tracker.

By the way, will anybody give the Acked-by or Reviewed-by on these
patches? I already received the comments without any Acked-by.

Regards
Haojian
