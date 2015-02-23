From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Mon, 23 Feb 2015 20:39:06 +0100
Subject: [PATCH v4 1/5] ARM: dts: pxa: add pwri2c to pxa device-tree
In-Reply-To: <87y4o04k21.fsf@free.fr> (Robert Jarzmik's message of "Sat, 14
 Feb 2015 15:57:58 +0100")
References: <1423761758-29159-1-git-send-email-robert.jarzmik@free.fr>
 <87y4o04k21.fsf@free.fr>
Message-ID: <87pp905sf9.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Robert Jarzmik <robert.jarzmik@free.fr> writes:

> Robert Jarzmik <robert.jarzmik@free.fr> writes:
>
>> pxa27x variant has 2 I2C busses on the SoC :
>>  - the casual I2C
>>  - the power I2C, normally driving power regulators, and capable of
>>  receiving orders on core frequency modifications
>>
>> Add the missing pwri2c to pxa27x description.
>>
>> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
>
> Hi Rob, Mark, Sergei,
>
> I'd like to queue that into the pxa/dt tree next week.
> Could I have a "Reviewed-by" ?
Queued in pxa/dt.

Cheers.

-- 
Robert
