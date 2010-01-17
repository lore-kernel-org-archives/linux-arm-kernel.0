From: mcuelenaere@gmail.com (Maurus Cuelenaere)
Date: Sun, 17 Jan 2010 13:57:04 +0100
Subject: s3c-hsotg driver problem
In-Reply-To: <3c17e3571001161800m14ca30cas1cca155f9880513d@mail.gmail.com>
References: <4B51B36C.6040308@gmail.com>
	<3c17e3571001161800m14ca30cas1cca155f9880513d@mail.gmail.com>
Message-ID: <4B530920.5020901@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Op 17-01-10 03:00, Barry Song schreef:
> In fact, I once used 12Mhz  external crystal, after setting PHYCLK
> right,  both USB 1.1 as host and 2.0 as gadget can work. The kernel
> version I used is 2.6.28.
>    

You say the kernel version you used is 2.6.28, I'm betting you weren't 
using Ben Dooks' driver then and this was Samsung's tree?
The kernel that is currently shipped with the device I'm porting for 
(SmartQ 7) is using 2.6.24, which also has Samsung's patches applied 
(and uses other drivers than in mainline).

AFAIK there are 2 (?) 'main' trees floating around with Samsung patches: 
2.6.24 and 2.6.28, then there are 2.6.29 and 2.6.31 (and newer) trees 
which contain patches from a mix of both and mainline.

What I'm looking for is getting everything to work with *mainline* 
drivers, so in the end I can push the SmartQ boards to mainline.

Regards,
Maurus Cuelenaere
