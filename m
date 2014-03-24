From: anish198519851985@gmail.com (anish singh)
Date: Mon, 24 Mar 2014 14:33:18 -0700
Subject: Disabling gcc inline operation
In-Reply-To: <532FFBDE.7030407@broadcom.com>
References: <CAK7N6vrgnNdFvo8as+DrhXurxP+SexN9gi3WFrX_SCO9i2Ybyw@mail.gmail.com>
 <532FFBDE.7030407@broadcom.com>
Message-ID: <CAK7N6voRqo5fztqHLM7BLG14GNrMXPu_fpS6weue8hZU5uUJ1w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 24, 2014 at 2:33 AM, Arend van Spriel <arend@broadcom.com> wrote:
> On 23/03/14 23:31, anish singh wrote:
>>
>> Many a time i have got a crash and it is difficult
>> to find out the exact function which crashed
>> because the crash stack doesn't show the "real"
>> function because gcc inlines many functions when
>> ever it desires or when it optimizes for speed.
>>
>> So i don't want gcc to inline any function instead
>> just call the function so that i can see the crash
>> stack of each function called. I just want to do
>> this for debugging. Please let me know how can
>> i do that?
>>
>> What switch command to pass to gcc in the make
>> of linux kernel?
>
>
> You tried to look at gcc.gnu.org, right? Your best options are -O0 and/or
> -Og for debugging purposes.
It worked with -fno-inline
>
> Regards,
> Arend
>
>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>> the body of a message to majordomo at vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>>
>
