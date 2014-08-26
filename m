From: olof@lixom.net (Olof Johansson)
Date: Mon, 25 Aug 2014 17:54:23 -0700
Subject: [PATCH] ARM: brcmstb: revert SMP support
In-Reply-To: <CAOesGMhmer-V9qXQboeULK91fkrVLQ=4uKuJtOOOnxMGs5WQfA@mail.gmail.com>
References: <1407960049-1591-1-git-send-email-computersforpeace@gmail.com>
 <20140825173542.GX18411@ld-irv-0074>
 <CAOesGMhmer-V9qXQboeULK91fkrVLQ=4uKuJtOOOnxMGs5WQfA@mail.gmail.com>
Message-ID: <CAOesGMgbF4aX8Y1Pr+WDG-rB3uyvx1fcmtejZ4RnJG-KpSSThw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 25, 2014 at 11:03 AM, Olof Johansson <olof@lixom.net> wrote:
> Hi,
>
> On Mon, Aug 25, 2014 at 10:35 AM, Brian Norris
> <computersforpeace@gmail.com> wrote:
>> Hi Matt, Olof,
>>
>> Can this go into 3.17? Besides the other improvements that need to be
>> made to this code, more people are noticing the build errors Russell
>> noticed previously.
>>
>>   http://article.gmane.org/gmane.linux.ports.arm.kernel/350226
>>
>> I meant to have put [PATCH -3.17] in the subject, in case that would
>> help it get the attention it deserved.
>
> Yeah, I'll apply this one directly.

Applied and pushed now. Likely missed today's -next.


-Olof
