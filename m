From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Fri, 23 Jul 2010 11:48:02 +0900
Subject: [PATCH]HRT support in Samsung S5P Platform
In-Reply-To: <AANLkTimiX2dIAPB8CwjYpIA6JjPXXRwogrpZ0IwR9RuN@mail.gmail.com>
References: <13968563.679171279522453031.JavaMail.weblogic@epml17>
	<009101cb28cd$290f8200$7b2e8600$%kim@samsung.com>
	<AANLkTimiX2dIAPB8CwjYpIA6JjPXXRwogrpZ0IwR9RuN@mail.gmail.com>
Message-ID: <AANLkTimH2q_D9wPRd5HmzSQKNf9J6yyjnolihKn7ZzQh@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 22, 2010 at 3:10 PM, Kyungmin Park
<kyungmin.park@samsung.com> wrote:
> On Wed, Jul 21, 2010 at 9:06 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
>> MADHAV SINGHCHAUHAN wrote:
>>>
>>> From: Madhav Singh <singh.madhav@samsung.com>
>>> Date: Mon, 19 Jul 2010 10:51:01 +0530
>>> Subject: [PATCH] HRT support in Samsung Tree
>>> This patch implements HRT support for Samsung plat-s5p.
>>> RTC has been used as CLOCKEVENT and SYSTIMER as CLOCKSOURCE.
>>>
>>> Signed-off-by: Madhav Chauhan <singh.madhav@samsung.com>
>>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>>
>> Hi,
>>
>> I'd like to say to MADHAV and Kyungmin....
>>
>> Actually, your patch(code) is same with my team's code in
>> git(git.kernel.org, kki_ap, 2.6.29-samsung,
>> arch/arm/plat-s5pc11x/hr-time-rtc.c)
>> But I couldn't find any credits or comments about that.
>>
>> If you copy some code from somewhere, please add credits and comments about
>> that.
>> It's very important.
>
> Right, it's my mistake can't check it. Madhav will add the credit and
> describe the original author.
> I talked to Mr. Lee jaechul and get the permission to send the patch.
>
> To Madhav,
>
> Next time, Add the From: Jaechul Lee at commit message and signed-off-by.
Actually it should be mentioned in the credits in source code itself
if this submission
is not much more than cleanup and polish.
