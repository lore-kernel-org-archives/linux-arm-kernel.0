From: vipulkumar.samar@st.com (vipul kumar samar)
Date: Wed, 13 Mar 2013 11:34:05 +0530
Subject: [PATCH v2 00/13] ARM: spear multiplatform support
In-Reply-To: <CAOh2x==O4OtpTPxgpBs5B0NZtbc6MkeyetsJz9AGDEAarA=OFQ@mail.gmail.com>
References: <1363106816-9603-1-git-send-email-arnd@arndb.de>
 <CAOh2x==O4OtpTPxgpBs5B0NZtbc6MkeyetsJz9AGDEAarA=OFQ@mail.gmail.com>
Message-ID: <514016D5.10808@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/13/2013 11:29 AM, Viresh Kumar wrote:
> On Wed, Mar 13, 2013 at 12:46 AM, Arnd Bergmann<arnd@arndb.de>  wrote:
>> This is the second time I post the SPEAr multiplatform patches.
>> It did not work out for 3.9, mostly because of conflicts against
>> patches in the DMA tree, but also because I did not push very
>> hard for these. The patches are basically unchanged now, just
>> some context differences since I rebased them on top of 3.9-rc2.
>>
>> I'm adding them to the arm-soc tree for 3.10 now. If there are
>> any bugs, let's fix them on top of this branch. It would be
>> good to get some more testing on the branch though.
>
> I thought i would meet you at Connect, but last time i didn't come and
> this time you :)
>
> Anyways thanks for all the good work you have done for SPEAr. These
> are already Acked by me
>
> @Vipul: Can you give these a try? Please consider following which we got
> from the last discussion:

ohk, i'll test this patch set and update you ASAP.

>
> From: Arnd...
>
> Thanks for testing out the patches. I forgot about the loadaddress,
> which indeed does not get set for multiplatform kernels, because
> the kernel does not know the correct address when it depends on
> the platform you are booting on.
>
> The recommended solution for this is to boot a normal 'vmlinux'
> or 'zImage' file rather than a uImage file. If you u-boot version
> is too old for that and you cannot update, you can manually
> call 'mkimage' to create a uImage file with the correct load
> address.

Ohk.

Regards
Vipul Samar
