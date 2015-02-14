From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 14 Feb 2015 22:36:57 +0100
Subject: [PATCH] ARM: pxa: pxa27x skip default device initialization with
 DT
In-Reply-To: <54D69260.3020204@zonque.org> (Daniel Mack's message of "Sat, 07
 Feb 2015 23:32:00 +0100")
References: <1423343914-32342-1-git-send-email-robert.jarzmik@free.fr>
 <54D69260.3020204@zonque.org>
Message-ID: <878ug0b2fa.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Daniel Mack <daniel@zonque.org> writes:

> On 02/07/2015 10:18 PM, Robert Jarzmik wrote:
>> When booting via DT, the default PXA devices must not have been probed
>> before, otherwise the augmented information from the device tree is
>> ignored.
>> 
>> This is the twin commit of commit 82ce44d104dc ("ARM: pxa3xx: skip
>> default device initialization when booting via DT").
>> 
>> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
>
> Looks good to me - thanks!
>
> Acked-by: Daniel Mack <daniel@zonque.org>
Thanks, queued to pxa/for-next.

Cheers.

--
Robert
