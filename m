From: fkan@apm.com (Feng Kan)
Date: Tue, 24 Sep 2013 20:33:04 -0700
Subject: General placement of platform drivers and header files
Message-ID: <CAL85gmAi9qZWdeHt5JWeEW-OuNKdxqt-0fPDeCugnpun_6BDKA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all:

I have some drivers like Queue Manager and co-processor driver that
are used by other
drivers like Ethernet. Would it be appropriate to locate these drivers
under one folder under
drivers/misc/arch_name/xxx.

My other question is on common header files (belonging to Queue
Manager) but is sourced
by Ethernet, where should those reside. Should they go under
linux/include/misc/arch_name
or directly sourced using the ../../../misc/arch_name/headerfile method.

-- 
Feng Kan | Engineer
Ph: 408.543.8382
Em: fkan at apm.com
