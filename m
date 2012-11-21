From: olof@lixom.net (Olof Johansson)
Date: Wed, 21 Nov 2012 02:18:11 -0800
Subject: [PATCH v3 00/18] ARM: Patchset for CLPS711X
In-Reply-To: <20121121063602.GA7615@quad.lixom.net>
References: <1353160644-22446-1-git-send-email-shc_work@mail.ru>
 <201211171545.22154.arnd@arndb.de>
 <20121121063602.GA7615@quad.lixom.net>
Message-ID: <CAOesGMj57uJkwz6qJZ1fsBubxxLFWRMdi8kP-gBzt8mR5R5oaw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 20, 2012 at 10:36 PM, Olof Johansson <olof@lixom.net> wrote:
> On Sat, Nov 17, 2012 at 03:45:21PM +0000, Arnd Bergmann wrote:
>> On Saturday 17 November 2012, Alexander Shiyan wrote:
>> > Here is a v3 patchset for a CLPS711X-target.
>> > The main direction of this patchset - approaching the platform to the
>> > possibility of using configurations with multiple platforms in a single
>> > kernel. Added support of the majority of the necessary kernel symbol.
>> > Also part of the driver code used only for the platform was moved to the
>> > board code and converted to the use of standard drivers.
>> >
>>
>> (+Linus Walleij)
>>
>> Thanks for sending the new version, as discussed on IRC. It's important
>> to mention here that the series depends on patches that Linus applied into
>> the gpio tree. Olof, if you merge these before I get to it, please apply
>> them on top of an appropriate branch from the GPIO tree. Linus, is
>> 2cad6a8a4c an appropriate commit to base on? I think that is the
>> olders one that can be used as a base here.
>
> Thanks, I've applied this on top of the pinctrl commit mentioned (based on
> Linus' reply), as well as the previous clps711x branch, since that seems to be
> what the series was based on. It sits in clpx711x/soc2 as a separate branch,
> but I'll pull it into next/soc with the other one.

Something really odd is going on.

The 2cad6a8a4c commit is not in any pinctrl branch at the moment. So
I'll drop this branch until we get this sorted out.


-Olof
