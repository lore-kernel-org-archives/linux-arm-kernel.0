From: mogambo.kztrj@gmail.com (Khushhua Mogambo)
Date: Sat, 30 Jan 2010 23:47:36 +0900
Subject: Static mappings at boottime
Message-ID: <2703439e1001300647q1149a357v3b3e9da6bd8c91cf@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dears

 my soc have very simple and limited device controllers. I have thought
maybe I can map all devices's register spaces using iotable_init in map_io.
And pass already mapped Virtual addr(and not phys addr) to device drivers
 via IORESOURCE_MEM.
i thinks that way i can do most use of virtual address space for ioremap
and I can set VMALLOC size to maximum possible. also drivers doesnt have
to worry about mapping(and no addr space is mapped twice in two code pieces)

is it considered good kernel porting practice? can we face any problem
after some times?

thanking you
M.Park
