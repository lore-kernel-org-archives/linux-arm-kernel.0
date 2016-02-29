From: dhdang@apm.com (Duc Dang)
Date: Mon, 29 Feb 2016 15:56:21 -0800
Subject: [GIT PULL 2/2] arm64: X-Gene platforms DTS changes queued for
 v4.6 - part2
In-Reply-To: <CABb+yY3cFCYZ3da4zp2UdCTMY6ubjfgMBEkMJ9pe+5OSE=p5+g@mail.gmail.com>
References: <CADaLNDkF8_DVYWPFtGU8tYsbbxDWZF9tozW=Zs3EuV4BqO6OuA@mail.gmail.com>
 <CABb+yY2A6bLoNqak5Y8YVLgv=mL1Cx6axnD1trMhKx646NNWFw@mail.gmail.com>
 <CADaLNDnqRkOqam1Xt+Oc+7BXnQKr2EQqSL-1AGsn5fKOWEDnvw@mail.gmail.com>
 <CABb+yY3cFCYZ3da4zp2UdCTMY6ubjfgMBEkMJ9pe+5OSE=p5+g@mail.gmail.com>
Message-ID: <CADaLNDnkFUDH250M4bPO14iCQXt5ciHgC0a_CU0fFTGQXhgC1A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 26, 2016 at 3:22 AM, Jassi Brar <jassisinghbrar@gmail.com> wrote:
> On Fri, Feb 26, 2016 at 2:20 PM, Duc Dang <dhdang@apm.com> wrote:
>> On Thu, Feb 25, 2016 at 8:28 PM, Jassi Brar <jassisinghbrar@gmail.com> wrote:
>>> On Fri, Feb 26, 2016 at 8:21 AM, Duc Dang <dhdang@apm.com> wrote:
>>>> Hi Arnd, Olof,
>>>>
>>>> This is the second part of DT changes on X-Gene platforms for v4.6,
>>>> which enables mailbox driver for X-Gene v2 platforms and also enable
>>>> SLIMpro Mailbox I2C driver (a client of the mailbox driver) for both
>>>> X-Gene v1 and v2 platforms.
>>>>
>>>> This series depends on the 3rd patch
>>>> (http://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/commit/arch/arm64/boot/dts/apm?id=be9c09bcca039d6df9ec736989cdafc68c93fed4)
>>>> of the series "mailbox: Add APM X-Gene platform mailbox driver"
>>>> (https://lkml.org/lkml/2016/2/12/749), which was already in linux-next
>>>> since Feb-15.
>>>>
>>>> Hi Jassi,
>>>>
>>>> Are you going to get the 3rd patch (dts patch) of series "mailbox: Add
>>>> APM X-Gene platform mailbox driver" to your tree? Otherwise, I will
>>>> need to create another pull request for Arnd and Olof.
>>>>
>>> Please create the pull request, I don't think mailbox tree is the
>>> right path for the patch.
>>
>> Thanks for your confirmation, Jassi.
>>
> I overlooked I had already applied it. Not sure if its better to revert it now.
Hi Jassi,

Arnd merged the mailbox DT node to arm-soc tree. So I think you can
revert the DT changes in your mailbox tree.

Thanks,
Duc Dang.
