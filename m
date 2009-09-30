From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 30 Sep 2009 20:10:26 +0800
Subject: 2.6.32-rc1: spitz boots but suspend/resume is broken
In-Reply-To: <bc64b4640909300509p6c682fa8rb5ce43c77c79f5@mail.gmail.com>
References: <20090930120655.GG1412@ucw.cz>
	<bc64b4640909300509p6c682fa8rb5ce43c77c79f5@mail.gmail.com>
Message-ID: <f17812d70909300510t106a07b1u3caae9ec4127e26f@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mmm.... if not due to kernel image size constraints, I'd really like to merge
all the zaurus configs into one.

On Wed, Sep 30, 2009 at 8:09 PM, Dmitry Eremin-Solenikov
<dbaryshkov@gmail.com> wrote:
> On Wed, Sep 30, 2009 at 4:06 PM, Pavel Machek <pavel@ucw.cz> wrote:
>> Hi!
>>
>> matrix keyboard driver needs to be enabled, otherwise it seems ok.
>>
>> Unfortunately, it does not respond to power button in any visible way
>> :-(. Any ideas what might be wrong/how to debug it?
>
> Enable gpio-keyboard driver, verify (or port power button to it :))
> and check that
> enable_wakeup is enabled.
>
> BTW: on tosa initially i had a problem w/ wakeup. The power button wasn't
> able to wake the device up. However there was another gpio that was OR of
> ?power button and AC-in gpios that had to be used for wakeup. Please check
> if the same design applies to your device.
>
>> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?Pavel
>> --
>> (english) http://www.livejournal.com/~pavelmachek
>> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
>>
>
>
>
> --
> With best wishes
> Dmitry
>
