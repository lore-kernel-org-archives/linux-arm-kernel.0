From: manabian@gmail.com (Joachim Eastwood)
Date: Fri, 26 Sep 2014 09:48:24 +0200
Subject: [PATCH v5] mfd: syscon: Decouple syscon interface from platform
 devices
In-Reply-To: <2553182.6YgvmDLuEA@wuerfel>
References: <1411360807-7750-1-git-send-email-pankaj.dubey@samsung.com>
 <000d01cfd946$521304f0$f6390ed0$@samsung.com>
 <CAGhQ9VxwTS9=biwp0nCKu2bVU2aNe679aKR=HU5rd_Uaw99sUw@mail.gmail.com>
 <2553182.6YgvmDLuEA@wuerfel>
Message-ID: <CAGhQ9VwAe7d7fX1Lw22ocxDSXjOZbvXdmG1u6_d5v7ptmYMYeg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26 September 2014 09:16, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday 26 September 2014 07:34:12 Joachim Eastwood wrote:
>> I am working on Cortex-M4 no-MMU platform that isn't upstream yet, btw.
>>
>
> Sorry for drifting off-topic, but this is very interesting to me. Can you
> say which one you are working on and what your timeline is for submitting
> it upstream?

It's NXP LPC18xx/43xx which is Cortex-M3/M4.

3.19 or 3.20 might be target.

Right now everything is in a github repository here:
https://github.com/manabian/linux-lpc

Most stuff are working now and I am in the process of clean it up and
adding documentation.

> I generally like to know about new platforms early, and sometimes we get
> multiple people working on the same one.

I see.

regards,
Joachim Eastwood
