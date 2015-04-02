From: manabian@gmail.com (Joachim Eastwood)
Date: Thu, 2 Apr 2015 18:36:50 +0200
Subject: [PATCH 4/6] ARM: dts: Add base DT for NXP LPC18xx and LPC4357
In-Reply-To: <3163497.OVbqFkjUY9@wuerfel>
References: <1427923243-26296-1-git-send-email-manabian@gmail.com>
 <1427923243-26296-5-git-send-email-manabian@gmail.com>
 <3163497.OVbqFkjUY9@wuerfel>
Message-ID: <CAGhQ9VxF2Ki6pLDZTQ1LstqxcwWQDT=X2B81PCV1aexnnU1Jow@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2 April 2015 at 16:25, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 01 April 2015 23:20:41 Joachim Eastwood wrote:
>> +/ {
>> +       aliases {
>> +               serial0 = &uart0;
>> +               serial1 = &uart1;
>> +               serial2 = &uart2;
>> +               serial3 = &uart3;
>> +       };
>
> Better move these to the board specific file.

Okay.

Looking at arch/arm/boot/dts/ it seems to be very common to have
aliases setup in SoC dtsi files, though.

regards,
Joachim Eastwood
