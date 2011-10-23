From: david.yangshuai@gmail.com (David Yang)
Date: Sun, 23 Oct 2011 14:51:10 +0800
Subject: Question about: linux-linaro-2.6.38.7 booting the ubuntu 10.10
	filesystem
In-Reply-To: <CALQsFOJ8tcDAUM7AuEvkR6NU5wtq939M9vVUJZDScznGgQFHBQ@mail.gmail.com>
References: <CALQsFO+iuraeVVDZLWL5JUibNE2a-WC3ksGj3PV=tPWfuhJX9A@mail.gmail.com>
	<CALQsFOJ+kYQ9iJfAPhcHtcWwA9A-5TFbUe+oyiTWrar=ZSN1_g@mail.gmail.com>
	<B85A65D85D7EB246BE421B3FB0FBB5930328693B98@dbde02.ent.ti.com>
	<CALQsFOJHiLVskuhGe-OsK8PdUxuR8Lv9idJcmf8vZEumenBUnw@mail.gmail.com>
	<CALQsFOLs-Jz5-yPGOZkpqumgUUq8V90mCrEJ1EBPvXSwMbVM3A@mail.gmail.com>
	<B85A65D85D7EB246BE421B3FB0FBB5930328B2D77E@dbde02.ent.ti.com>
	<CALQsFOKEXCmaHdo7hj25CgjYFijodu6qs1okSwkfNPmuOz6GJg@mail.gmail.com>
	<CALQsFOKjH+k6e6tS4HoNrBvB9BdNYfz3F8P-veZtgk6fyOk-Zw@mail.gmail.com>
	<CALQsFOLjbBmvPC5iU_cY3LrEe03Z8q90mm5UsS2KoqVQsLjivA@mail.gmail.com>
	<CALQsFO+AbEH-LtEYCY7wDZW=7U=wYZrQcMPeoDio_BdkByWTcw@mail.gmail.com>
	<20111022133759.GB21374@n2100.arm.linux.org.uk>
	<CALQsFOJt6Z7J=QiS1fsieZYvY+mjv4YFZVJHzp69DEBtAA_bfQ@mail.gmail.com>
	<CALQsFOJ8tcDAUM7AuEvkR6NU5wtq939M9vVUJZDScznGgQFHBQ@mail.gmail.com>
Message-ID: <CALQsFOJWrdeFm+pkwz5NrcVuOA=XDFYsqKtcbUrZh1KmNCECKA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Problem fixed!!

I replace the futex.c futex.h plist.h plist.c  from the standard kernel 2.6.38.8


And now I could boot the ubuntu10.10

Thanks your reply!!

Best Regards,
David

On 10/23/11, David Yang <david.yangshuai@gmail.com> wrote:
> I have selected the HAVE_SCHED_CLOCK and implemnt the init_sched_clock
> fuction?
>
> But the problem is the same?
>
> So far ,I can get the login prompt  only when I select the preempiable
> kernel .
>
> On 10/23/11, David Yang <david.yangshuai@gmail.com> wrote:
>> No,I just ported the kernel from 2.6.33 to 2.6.38.
>>
>> So I didn't select the HAVE_SCHED_CLOCK?
>>
>> And I have tested it.
>>
>> When I select the HAVE_SCHED_CLOCK.
>> the kernel will hang after uncompressing the kernel.
>>
>>
>> Best Regards,
>> David
>>
>>
>>
>> On Sat, Oct 22, 2011 at 9:37 PM, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>>> On Sat, Oct 22, 2011 at 05:35:52PM +0800, David Yang wrote:
>>>> ?I found in my timer driver,I didn't implement the "init_sched_clock"
>>>> function.
>>>
>>> Have you selected HAVE_SCHED_CLOCK ?
>>>
>>
>
