From: stillcompiling@gmail.com (Joshua Clayton)
Date: Tue, 14 Feb 2017 04:31:24 -0800
Subject: Debug kernel oops
In-Reply-To: <CAA2oCO=48kuhqZC1pK4NhgWS=FFexRwoak4ks9aRaHoYNmESTw@mail.gmail.com>
References: <CAA2oCO=48kuhqZC1pK4NhgWS=FFexRwoak4ks9aRaHoYNmESTw@mail.gmail.com>
Message-ID: <1757589.1i8MyMhxGJ@diplodocus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, February 13, 2017 11:35:43 PM PST Madhu K wrote:
> Hi All,
> 
> How to debug the kernel oops for arm boards?
> 
> Below is my board and setup details.
> 
> 1) I am using Beaglebone black board which is running with 4.9.2 kernel
> version.
> 2) I wrote some i2c driver on host machine, it is cross compiled for arm
> and loaded on beaglebone black.
> 3) Insmod is proper, but while unloading the module I am seeing some kernel
> oops.
> 4) How to debug that oops? which tools we have to use?
> 
dmesg is your first tool.
And the oops itself is your second debugging tool.
There are plenty of resources on how to decode an oops, such as
... (goes and types "kernel oops example" into  a web browser search),
http://opensourceforu.com/2011/01/understanding-a-kernel-oops/

Then add some extra print statements (temporary, for debugging)
to enable you to understand what you are doing wrong.

Good luck. 
> Thanks in advance
> Madhu
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
