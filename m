From: olof@lixom.net (Olof Johansson)
Date: Tue, 16 Oct 2012 11:42:23 -0700
Subject: [RFC PATCHv2] ARM: vt8500: Convert arch-vt8500 to multiplatform
In-Reply-To: <1350412901.16703.1.camel@gitbox>
References: <1349942353-14972-1-git-send-email-linux@prisktech.co.nz>
 <20121016181758.GA1801@quad.lixom.net>
 <1350412901.16703.1.camel@gitbox>
Message-ID: <CAOesGMg7P602xerMjm3KjSh59Qt26URDQK-boVjnPB2v9kdCLg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 16, 2012 at 11:41 AM, Tony Prisk <linux@prisktech.co.nz> wrote:
> On Tue, 2012-10-16 at 11:17 -0700, Olof Johansson wrote:
>> On Thu, Oct 11, 2012 at 08:59:13PM +1300, Tony Prisk wrote:
>> > This patch completes the conversion to ARCH_MULTI_V5 for arch-vt8500.
>> > Removed /mach/include/ and remaining unneeded files.
>> >
>> > Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
>>
>> Acked-by: Olof Johansson <olof@lixom.net>
>>
>> I think it's time to add a defconfig for vt8500 so we get build coverage. Can
>> you please do so for 3.8, maybe as a part of the branch this patch goes in?
>>
>>
>> Thanks!
>>
>>
>> -Olof
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
> I thought the ARCH_MULTI def_configs would cover it from 3.8?
>
> Or would you like a vt8500_defconfig to help build the ARCH_MULTI
> configs?
>
> Either way, I will get it done and included in this branch.

Yeah, as mentioned in my reply to Arnd, the multiconfig would be
sufficient, just make sure it contains the drivers you need for your
platform(s) to work well.


-Olof
