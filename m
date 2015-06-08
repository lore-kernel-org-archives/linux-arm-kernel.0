From: holler@ahsoftware.de (Alexander Holler)
Date: Mon, 08 Jun 2015 20:18:40 +0200
Subject: [PATCH 00/21] On-demand device registration
In-Reply-To: <5575DB8D.50000@ahsoftware.de>
References: <1432565608-26036-1-git-send-email-tomeu.vizoso@collabora.com>
 <CAL_Jsq+EWLEJhRudTGAwYsOg4tX2-pGhygeQGHae9RL8rBpMiA@mail.gmail.com>
 <556F5C24.1030101@linaro.org> <5570B783.1050808@ahsoftware.de>
 <557589D9.1050008@melag.de> <5575DB8D.50000@ahsoftware.de>
Message-ID: <5575DC80.4040608@ahsoftware.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 08.06.2015 um 20:14 schrieb Alexander Holler:
> Am 08.06.2015 um 14:26 schrieb Enrico Weigelt, metux IT consult:
>> Am 04.06.2015 um 22:39 schrieb Alexander Holler:
>>
>>  > As it seems to have been forgotten or overread, I've mentioned in my
>>> series of patches last year that, with a few changes, it's possible to
>>> let the algorithm I've used (dfs) to spit out all drivers which can be
>>> initialized in parallel.
>>
>> Unfortunately, I've missed that ... could you please resend you patches?
>> Boot time reduction is one of the topics on my 2do in several weeks.
>
> https://lkml.org/lkml/2014/5/12/452
>

And don't forget patch 10/9 which fixed a bug in my previous patch 
series and which alos was the reason for the large difference in boot 
times with and without deps:

https://lkml.org/lkml/2014/5/13/567
