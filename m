From: yegorslists@googlemail.com (Yegor Yefremov)
Date: Tue, 19 May 2015 10:33:13 +0200
Subject: [PATCH] arm: boot: dts: add DTS for Baltos IR5221
In-Reply-To: <20150513155012.GI15563@atomide.com>
References: <1431468917-27697-1-git-send-email-balbi@ti.com>
 <20150513074002.0b7b8dda@ipc1.ka-ro> <20150513152904.GC4201@saruman.tx.rr.com>
 <20150513155012.GI15563@atomide.com>
Message-ID: <CAGm1_kvc+PiK8CbpaEWR-1vGLs5F0hMoWaEGXokg97+6q5mOUg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 13, 2015 at 5:50 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Felipe Balbi <balbi@ti.com> [150513 08:32]:
>> On Wed, May 13, 2015 at 07:40:02AM +0200, Lothar Wa?mann wrote:
>> > >
>> > Should these be ordered alphabetically?
>>
>> why ?
>
> In general the alphabetical ordering helps to avoid merge
> conflicts when new things are added later on as they are
> not all added to the end. So yeah I have a slight sorting
> preference there too to make my life easier in the future :)

I've sent v2, but I left network components order as is. It was
borrowed from am335x-evmsk and represents somehow the hierarchy of
CPSW: at first MAC, then MDIO and then slaves with their own settings.

Regards,
Yegor
