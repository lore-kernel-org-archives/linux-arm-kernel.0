From: david.yangshuai@gmail.com (David Yang)
Date: Thu, 20 Oct 2011 21:05:45 +0800
Subject: Question about: linux-linaro-2.6.38.7 booting the ubuntu 10.10
	filesystem
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB5930328B2D77E@dbde02.ent.ti.com>
References: <CALQsFO+o+zQJZiksb+2fW8b_kdTv6tqhjxYU6owv=hMhbk=92A@mail.gmail.com>
	<CAK5ve-LetP_jUyi22T0QhPkHgNqjFBuzuMa5+VnEfWvzFpy3Wg@mail.gmail.com>
	<CALQsFO+iuraeVVDZLWL5JUibNE2a-WC3ksGj3PV=tPWfuhJX9A@mail.gmail.com>
	<CALQsFOJ+kYQ9iJfAPhcHtcWwA9A-5TFbUe+oyiTWrar=ZSN1_g@mail.gmail.com>
	<B85A65D85D7EB246BE421B3FB0FBB5930328693B98@dbde02.ent.ti.com>
	<CALQsFOJHiLVskuhGe-OsK8PdUxuR8Lv9idJcmf8vZEumenBUnw@mail.gmail.com>
	<CALQsFOLs-Jz5-yPGOZkpqumgUUq8V90mCrEJ1EBPvXSwMbVM3A@mail.gmail.com>
	<B85A65D85D7EB246BE421B3FB0FBB5930328B2D77E@dbde02.ent.ti.com>
Message-ID: <CALQsFOKEXCmaHdo7hj25CgjYFijodu6qs1okSwkfNPmuOz6GJg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi,Afzal

  It's not zero.



Best Regards,
Shuai

On 10/20/11, Mohammed, Afzal <afzal@ti.com> wrote:
> Hi David,
>
> On Thu, Oct 20, 2011 at 17:32:25, David Yang wrote:
>> another log when booting ubuntu10.10:
>>
>>
>> the PC stopped at futex_wake() again!
>>
>
> Please pass "printk.time=1" from commandline, and check the
> Kernel logs whether timing shown are zero.
>
> Regards
> Afzal
>
