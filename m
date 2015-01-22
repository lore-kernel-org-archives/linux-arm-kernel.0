From: 21cnbao@gmail.com (Barry Song)
Date: Thu, 22 Jan 2015 19:52:53 +0800
Subject: [GIT PULL RESEND] CSR atlas7 debug ports for 3.20
In-Reply-To: <20150121222708.GA24851@quad.lixom.net>
References: <CAGsJ_4yJTApS6RwGCEFcBGT+L1f8Gn3DnmzGAKQc3H2SZZJvcw@mail.gmail.com>
 <20150119191258.GB16883@quad.lixom.net>
 <CAGsJ_4ydqDxEqmEbX-NfQx75KOba7-BTU8Rnx0r=pobh4JT=QQ@mail.gmail.com>
 <20150121222708.GA24851@quad.lixom.net>
Message-ID: <CAGsJ_4yFvBu8eG+Z3uTBEjurbB9q1h8N3m6hwBioU9RyRRMTUg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-01-22 6:27 GMT+08:00 Olof Johansson <olof@lixom.net>:
> On Tue, Jan 20, 2015 at 08:03:42PM +0800, Barry Song wrote:
>> 2015-01-20 3:12 GMT+08:00, Olof Johansson <olof@lixom.net>:
>> > On Wed, Jan 14, 2015 at 09:24:19PM +0800, Barry Song wrote:
>> >> Hi Arnd, Kevin, Olof,
>> >>
>> >> The following changes since commit
>> >> b7392d2247cfe6771f95d256374f1a8e6a6f48d6:
>> >>
>> >>   Linux 3.19-rc2 (2014-12-28 16:49:37 -0800)
>> >>
>> >> are available in the git repository at:
>> >>
>> >>   git://git.kernel.org/pub/scm/linux/kernel/git/baohua/linux.git
>> >> tags/atlas7-lldebug-for-3.20
>> >>
>> >> for you to fetch changes up to 98898ee43a94375cf814b86fb7f485c39fb2c072:
>> >>
>> >>   ARM: sirf: add two debug ports for CSRatlas7 SoC (2015-01-14 20:56:09
>> >> +0800)
>> >>
>> >> ----------------------------------------------------------------
>> >> add debug ports for CSRatlas7 SoC
>> >>
>> >> Because Marco chip has never shipped to customers and has been replaced
>> >> by Atlas7, so we do the below
>> >> - drop Marco's debug port
>> >> - add debug ports for Atlas7
>> >>
>> >> we also move to use DEBUG_UART_PHYS/VIRT for all CSR ports
>> >>
>> >> ----------------------------------------------------------------
>> >> Barry Song (1):
>> >>       ARM: sirf: drop Marco low-level debug port
>> >>
>> >> Guo Zeng (1):
>> >>       ARM: sirf: add two debug ports for CSRatlas7 SoC
>> >
>> > These entries are not sorted. If you look at the file, in particular
>> > DEBUG_UART_PHYS and DEBUG_UART_VIRT, you see that they are sorted in
>> > address
>> > order. Your new entries are just appended. That's not right.
>>
>> Olof, fixed here:
>> https://git.kernel.org/cgit/linux/kernel/git/baohua/linux.git/commit/?id=01ea63d99397fcdcb9cc235c77a8e11f4e4a63e9
>>
>> and tag was re-built.
>
> In the future, please always send a full fresh pull request so I see
> the diffstat that you intended to send and can compare it with what I
> actually merged.
>
> Merged into next/soc.

ok. will take care next time :-)

>
> -Olof

barry
