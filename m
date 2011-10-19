From: bryan.wu@canonical.com (Bryan Wu)
Date: Wed, 19 Oct 2011 22:13:17 +0800
Subject: Question about: linux-linaro-2.6.38.7 booting the ubuntu 10.10
	filesystem
In-Reply-To: <CALQsFO+o+zQJZiksb+2fW8b_kdTv6tqhjxYU6owv=hMhbk=92A@mail.gmail.com>
References: <CALQsFO+o+zQJZiksb+2fW8b_kdTv6tqhjxYU6owv=hMhbk=92A@mail.gmail.com>
Message-ID: <CAK5ve-LetP_jUyi22T0QhPkHgNqjFBuzuMa5+VnEfWvzFpy3Wg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

David,

Could you please tell us what's kind of hardware are you trying with
Ubuntu/Linaro?

Thanks
-Bryan

On Wed, Oct 19, 2011 at 9:52 PM, David Yang <david.yangshuai@gmail.com> wrote:
> hi,all
>
> ? I'm trying booting the ubuntu10.10 using the kernel linux-linaro-2.6.38.7.
> ? And I use the serial ttyS0 as the Console.
> ? But the booting always stopped after logging?
>
> ? ? ? Freeing init memory: 124K
> ? ? ? init: sreadahead main process (414) terminated with status 1
> ? ? ? init: procps main process (429) terminated with status 255
> ? ? ? * Setting preliminary keymap...
>
> ? And then the ttyS0 doesn't response.
>
> ? But when I boot the cramfs made using busybox with the same
> kernel,I can get the login prompt.And then I can login and use it.
>
> ? I also tried the ubuntu9.10,it has the same problem.
>
> ? So I don't know why.
>
> ? Any suggestion is welcome?
>
> ? Thanks?
>
>
> Best Regards,
> David
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>



-- 
Bryan Wu <bryan.wu@canonical.com>
Kernel Developer ? ?+86.138-1617-6545 Mobile
Ubuntu Kernel Team
Canonical Ltd. ? ? ?www.canonical.com
Ubuntu - Linux for human beings | www.ubuntu.com
