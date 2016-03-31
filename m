From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Thu, 31 Mar 2016 14:54:28 +0200
Subject: [PATCH v7 01/20] PM / devfreq: exynos: Add generic exynos bus
 frequency driver
In-Reply-To: <CAGTfZH0mgxyQPKBTX=ZXgtSn=bQ2zAMSNMHfO+OXh3U5qrUr4g@mail.gmail.com>
References: <1459415165-32613-1-git-send-email-cw00.choi@samsung.com>
 <1459415165-32613-2-git-send-email-cw00.choi@samsung.com>
 <56FD13D2.1050300@samsung.com>
 <CAGTfZH0mgxyQPKBTX=ZXgtSn=bQ2zAMSNMHfO+OXh3U5qrUr4g@mail.gmail.com>
Message-ID: <56FD1E04.8050808@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/31/2016 02:28 PM, Chanwoo Choi wrote:
>> > You should use IS_ERR() instead of IS_ERR_OR_NULL(), since functions
>> > of which the return value is being tested return only ERR_PTR() values.
>> > IS_ERR_OR_NULL() suggest NULL values are possible and then constructs
>> > like
>> >         if (IS_ERR_OR_NULL(result))
>> >                 return PTR_ERR(result);
>> >
>> > are not correct anyway.
>
> OK. I'll use IS_ERR() instead of IS_ERR_OR_NULL()

Thanks, I forgot to mention there is similar issue in patches
5/20 and 6/20.

--
Regards
Sylwester
