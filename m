From: jhautbois@gmail.com (Jean-Michel Hautbois)
Date: Tue, 2 Mar 2010 10:07:49 +0100
Subject: [kGDB]Cannot compile KGDB on ARM SMP
Message-ID: <8cad0aa1003020107g3aae0875n1da8c442d9909f96@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi there !

I am  curently trying to compile kgdb on an ARM SMP core.
I have the following error :
kernel/kgdb.c:1481: undefined reference to `kgdb_roundup_cpus'

When I am looking at the function 'kgdb_roundup_cpus', it is defined
for x86, mips, blackfin, powerpc, but not for ARM.
Is there any specific reason for that ?
I can't see why...

Thanks in advance for your help !

Best Regards,
JM
