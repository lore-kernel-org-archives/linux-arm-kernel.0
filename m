From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Wed, 29 May 2013 21:05:41 +0200
Subject: [PATCH 00/10] clk: mvebu: restructure SoC clock drivers
In-Reply-To: <20130529190204.6058.85682@quantum>
References: <1368234490-31416-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <20130529190204.6058.85682@quantum>
Message-ID: <51A65185.1020307@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/29/2013 09:02 PM, Mike Turquette wrote:
> Quoting Sebastian Hesselbarth (2013-05-10 18:08:00)
>> Marvell EBU SoCs share some common clock functions that register core
>> clocks or clock gates from SoC specific data. These clock drivers are
>> organized by function and over time the drivers filled up with #ifdefs
>> to separate different SoC specific code.
>>
...
>> @Mike: As this only touches MVEBU related code, I suggest to take it
>> all through the corresponding ARM branch.
>>
> Sorry for the tardy response.  This cleanup looks really good.  If it's
> not too late:
>
> Acked-by: Mike Turquette<mturquette@linaro.org>
>
> If the branch is already pulled into arm-soc don't worry about the Ack.

Mike,

thanks for the Ack, the corresponding pull request has been sent some
hours ago by Jason Cooper. It has not been pulled into arm-soc, so it
is just in time ;)

Sebastian
