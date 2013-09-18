From: wbx@openadk.org (Waldemar Brodkorb)
Date: Wed, 18 Sep 2013 12:27:01 +0200
Subject: problem booting linux with qemu-system-arm -M spitz
Message-ID: <20130918102701.GJ14246@waldemar-brodkorb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kernel hackers,

I am trying to run Linux on Qemu/arm emulator with machine type
spitz. In the past this worked fine.
Now with Linux version 3.9.11 it does not boot anymore. 
(blank screen, no kernel messages)

I used git bisect to find the commit, which breaks the boot:
commit 4e8ee7de227e3ab9a72040b448ad728c5428a042
Author: Will Deacon <will.deacon@arm.com>
Date:   Wed Nov 23 12:26:25 2011 +0000

I am using Qemu 1.6.0 on a Debian/x86_64 host.

Any help would be appreciated.

Thanks in advance
 Waldemar
