From: dean.sinaean@gmail.com (Dean)
Date: Mon, 13 Jan 2014 19:54:11 +0800
Subject: is ioremap_cached() working under linux?
Message-ID: <52D3D3E3.5080302@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, all,
    Our system uses a FPGA chip which has two ARM cores in it. We 
developed a DDR memory controller on FPGA which is connected to ARM via 
AXI system bus.
    What I am trying to do is to test if the implemented DDR memory 
controller works with L2 Cache.
    Can I do this by ioremap_cached the DDR memory and then do 
read/writes on it?

    What I am thinking is:
    (1) ioremap_cached the memory region.
    (2) do read/write operations on it.
    (3) flush_cache_all();

Will my idea work?

Thank you all.
Dean.
