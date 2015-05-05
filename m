From: manabian@gmail.com (Joachim Eastwood)
Date: Tue, 5 May 2015 10:45:15 +0200
Subject: [PATCH v2 0/2] reset driver for NXP LPC18xx family
In-Reply-To: <1430814827.3035.10.camel@pengutronix.de>
References: <1430779956-12490-1-git-send-email-manabian@gmail.com>
 <1430814827.3035.10.camel@pengutronix.de>
Message-ID: <CAGhQ9VzsyVVZS6kNV3YeFq89=f3CaEX0NDFd8hTb9RU0PrXsEQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5 May 2015 at 10:33, Philipp Zabel <p.zabel@pengutronix.de> wrote:
> Am Dienstag, den 05.05.2015, 00:52 +0200 schrieb Joachim Eastwood:
>> This patch set adds a reset driver for NXP LPC18xx/43xx devices.
>>
>> Changes in v2:
>> * clean up header includes
>> * prefix M0 reset defines with LPC43XX
>> * fix comment about M0 reset lines
>> * reorganize reset call chains
>> * add reset number table to dt doc
>
> I am satisfied with the changes.

Excellent!

> I'd like a short patch description in both patches before applying them.

ah, yes, the commit messages are a bit lacking...

I'll send out a v3 later today.

regards,
Joachim Eastwood
