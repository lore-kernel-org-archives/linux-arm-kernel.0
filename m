From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon, 10 Jun 2013 18:31:13 +0200
Subject: [PATCH v4 2/6] clocksource: add Marvell Orion SoC timer
In-Reply-To: <51B5F8FE.5090508@linaro.org>
References: <1370536034-23956-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1370856955-10514-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <51B5F8FE.5090508@linaro.org>
Message-ID: <51B5FF51.6090708@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/10/13 18:04, Daniel Lezcano wrote:
> On 06/10/2013 11:35 AM, Sebastian Hesselbarth wrote:
>> This patch add a DT enabled driver for timers found on Marvell Orion SoCs
>> (Kirkwood, Dove, Orion5x, and Discovery Innovation). It installs a free-
>> running clocksource on timer0 and a clockevent source on timer1.
>> Corresponding device tree documentation is also added.
>>
>> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
>
> It looks good for me.
>
> Sebastian,
>
> shall I take it through my tree (it will go to Thomas's tree) ?

Daniel,

I checked MAINTAINERS and thought clocksource, i.e. patch 2/6, would go
through Thomas' or John's tree? If you want to take it, I am fine with
it but guess I am not the one to choose here ;)

Sebastian
