From: david.yangshuai@gmail.com (David Yang)
Date: Wed, 19 Oct 2011 21:52:59 +0800
Subject: Question about: linux-linaro-2.6.38.7 booting the ubuntu 10.10
	filesystem
Message-ID: <CALQsFO+o+zQJZiksb+2fW8b_kdTv6tqhjxYU6owv=hMhbk=92A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi,all

   I'm trying booting the ubuntu10.10 using the kernel linux-linaro-2.6.38.7.
   And I use the serial ttyS0 as the Console.
   But the booting always stopped after logging?

       Freeing init memory: 124K
       init: sreadahead main process (414) terminated with status 1
       init: procps main process (429) terminated with status 255
       * Setting preliminary keymap...

   And then the ttyS0 doesn't response.

   But when I boot the cramfs made using busybox with the same
kernel,I can get the login prompt.And then I can login and use it.

   I also tried the ubuntu9.10,it has the same problem.

   So I don't know why.

   Any suggestion is welcome?

   Thanks?


Best Regards,
David
