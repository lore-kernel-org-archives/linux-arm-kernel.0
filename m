From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 14 Feb 2015 15:57:58 +0100
Subject: [PATCH v4 1/5] ARM: dts: pxa: add pwri2c to pxa device-tree
In-Reply-To: <1423761758-29159-1-git-send-email-robert.jarzmik@free.fr>
 (Robert Jarzmik's message of "Thu, 12 Feb 2015 18:22:34 +0100")
References: <1423761758-29159-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <87y4o04k21.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Robert Jarzmik <robert.jarzmik@free.fr> writes:

> pxa27x variant has 2 I2C busses on the SoC :
>  - the casual I2C
>  - the power I2C, normally driving power regulators, and capable of
>  receiving orders on core frequency modifications
>
> Add the missing pwri2c to pxa27x description.
>
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>

Hi Rob, Mark, Sergei,

I'd like to queue that into the pxa/dt tree next week.
Could I have a "Reviewed-by" ?

Cheers.

--
Robert
