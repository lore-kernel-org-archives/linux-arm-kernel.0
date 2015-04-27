From: tyler.baker@linaro.org (Tyler Baker)
Date: Mon, 27 Apr 2015 11:58:06 -0700
Subject: n900 in 4.1-rc0
In-Reply-To: <20150426102046.GA4340@amd>
References: <20150416093234.GA17423@amd>
 <CANMBJr5G2RpS1sw3N8FYitqzqFu8a2Gqj__i_742FZrMYuusOA@mail.gmail.com>
 <20150426102046.GA4340@amd>
Message-ID: <CANMBJr6x40AH586GFjAwm5-qpjefrgk4H0xhLQ3m+VwvtRUAaw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pavel,

On 26 April 2015 at 03:20, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
>
>> > Just tried booting 4.1-rc0 on n900 (commit
>> > 34c9a0ffc75ad25b6a60f61e27c4a4b1189b8085) and it is broken.
>> >
>> > Any ideas?
>>
>> Looks like DT and legacy booting are working fine in our
>> labs. [0][1]
>
> Interesting web pages, thanks.

No problem.

>
> I noticed that legacy booting indicates broken today, but... Is there
> list of your targets somewhere?

It looks to have failed it's boot test on the stable v3.14 based LSK
today, however it is booting fine still on the upstream development
trees. You can also use a query[0] to refine your view if you would
like. The up to date list of targets can be found here[1] and if
interested in receiving email reports you can subscribe here[2].

>
> Best regards,
>                                                                         Pavel
>
>
>
>> [0] http://kernelci.org/boot/omap3-n900/
>> [1] http://kernelci.org/boot/omap3-n900,legacy/
>
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

Cheers,

Tyler

[0] http://kernelci.org/boot/?n900&fail
[1] https://wiki.linaro.org/ProductTechnology/kernelci.org
[2] https://lists.linaro.org/mailman/listinfo/kernel-build-reports
