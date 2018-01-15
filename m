From: keescook@chromium.org (Kees Cook)
Date: Mon, 15 Jan 2018 12:00:50 -0800
Subject: [PATCH] arm64: Stop printing the virtual memory layout
In-Reply-To: <20180115181839.keb4gyodwgruolk6@armageddon.cambridge.arm.com>
References: <20171219192810.22537-1-labbott@redhat.com>
 <CAGXu5jKH+XZLor5hApTpzbeq0SBz4Qo-AarAFjAfWXM5p3uSVA@mail.gmail.com>
 <CAGXu5j+Re4ZrZp4+RSoHtLvuo2bMqdU-2Ja2OWnYB-1-p5GLOQ@mail.gmail.com>
 <20180115181839.keb4gyodwgruolk6@armageddon.cambridge.arm.com>
Message-ID: <CAGXu5j+TKWPXBT+CQbcGVK7A1MNFxHorh15zeZDEPkTBgGSNwg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 15, 2018 at 10:18 AM, Catalin Marinas
<catalin.marinas@arm.com> wrote:
> On Tue, Jan 09, 2018 at 03:02:12PM -0800, Kees Cook wrote:
>> On Tue, Dec 19, 2017 at 1:04 PM, Kees Cook <keescook@chromium.org> wrote:
>> > On Tue, Dec 19, 2017 at 11:28 AM, Laura Abbott <labbott@redhat.com> wrote:
>> >> Printing kernel addresses should be done in limited circumstances, mostly
>> >> for debugging purposes. Printing out the virtual memory layout at every
>> >> kernel bootup doesn't really fall into this category so delete the prints.
>> >> There are other ways to get the same information.
>> >
>> > In looking at this patch, I wonder: is there anything listed here that
>> > is _missing_ from CONFIG_PTDUMP? I would expect all of these to
>> > already be listed there, but I thought I'd ask...
>> >
>> > Regardless:
>> >
>> > Acked-by: Kees Cook <keescook@chromium.org>
>> >
>> > -Kees
>> >
>> >>
>> >> Signed-off-by: Laura Abbott <labbott@redhat.com>
>>
>> Did this patch get picked up? I don't see it in -next.
>
> I queued it now, should appear soon.

Great, thanks!

-Kees

-- 
Kees Cook
Pixel Security
