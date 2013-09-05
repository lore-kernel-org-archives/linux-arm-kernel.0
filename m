From: vijay.kilari@gmail.com (Vijay Kilari)
Date: Thu, 5 Sep 2013 19:13:52 +0530
Subject: KGDB on ARMv7
Message-ID: <CALicx6tnK8hWOqsHgbjjFMWVBxsDUoW6XVTSnTz=Li5MdGa_Qw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

   I am looking at implementation of KGDB support on kernel for ARMv7.
I want to know about kernel implementation for step & next commands
debugging for ARMv7
Does it use HW step debugging?

Because command 's' from GDB host is not processed like other
commands. I want to find out
what is the special processing done by ARM/Kernel for this?

Thanks & Regards
Vijay
