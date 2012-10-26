From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Fri, 26 Oct 2012 13:09:18 +0200 (CEST)
Subject: [BUG] read_current_timer undefined
Message-ID: <Pine.LNX.4.64.1210261306370.20835@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A recent commit

commit 923df96b9f31b7d08d8438ff9677326d9537accf
Author: Will Deacon <will.deacon@arm.com>
Date:   Fri Jul 6 15:46:45 2012 +0100

    ARM: 7451/1: arch timer: implement read_current_timer and get_cycles

breaks linkage of modules, using get_cycles(), e.g. 

ERROR: "read_current_timer" [fs/ext4/ext4.ko] undefined!

This is present in "next" of 23 October.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
