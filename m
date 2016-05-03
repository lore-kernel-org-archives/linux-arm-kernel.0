From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 3 May 2016 19:26:51 +0900
Subject: [PATCH 1/7] reset: add devm_reset_controller_register API
In-Reply-To: <1462270670.3617.49.camel@pengutronix.de>
References: <1462099023-11819-1-git-send-email-yamada.masahiro@socionext.com>
 <1462099023-11819-2-git-send-email-yamada.masahiro@socionext.com>
 <1462270670.3617.49.camel@pengutronix.de>
Message-ID: <CAK7LNAR699QqYvWdFPtnBc=bLyMLvhCvnKJQCR4YHCy7HQTjUQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2016-05-03 19:17 GMT+09:00 Philipp Zabel <p.zabel@pengutronix.de>:
> Hi Masahiro,
>
> Am Sonntag, den 01.05.2016, 19:36 +0900 schrieb Masahiro Yamada:
>> Add a device managed API for reset_controller_register().
>>
>> This helps in reducing code in .remove callbacks and sometimes
>> dropping .remove callbacks entirely.
>>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>
> Thank you for these patches. Except for the issue with the lpc18xx patch
> they all look good to me.
> If you don't mind, I'll drop the lpc18xx patch for now and apply the
> others.
>

It is OK with me, but I do not understand what is the problem.

Could you answer my question in the 3/7 thread?



-- 
Best Regards
Masahiro Yamada
