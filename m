From: alchark@gmail.com (Alexey Charkov)
Date: Sun, 27 Feb 2011 19:42:44 +0300
Subject: PATCH [1/1] V2 - Clock Support for VT8500/WM8505
In-Reply-To: <76F764B079F92A4E843589C893D0A0228D57@SERVER.prisktech.co.nz>
References: <76F764B079F92A4E843589C893D0A0228D57@SERVER.prisktech.co.nz>
Message-ID: <AANLkTik+rVWZ5fMshO+NFU6UbJ+7xEimvKFZJ-kxsWc8@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/2/27 Linux Mailing List Email Account <linux@prisktech.co.nz>:
> Patch to provide clock support on VT8500-/WM8505- based SoC.
>
> V2:? Included missing mach/clkdev.h
>
> ???? Fix errors in clocks-vt8500.c
>

Tony, you should probably consider using your real name instead of
"Linux Mailing List Email Account" here. Also, your sign-off is
missing in this submission.

As for the patch itself, it looks quite awesome to me. Just add error
handling to ioremap calls and count the time you are busy-waiting for
the status registers (and put cpu_relax inside the loop).

Have you tested this code with both VT8500 and WM8505 enabled in the
same kernel image?

Best regards,
Alexey
