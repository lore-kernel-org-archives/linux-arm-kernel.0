From: luffy.sun@ymail.com (Luffy Sun)
Date: Fri, 03 Aug 2012 01:51:37 -0000
Subject: Crashme test cause arm data abort vector modified
Message-ID: <1343958694.1286.YahooMailNeo@web121603.mail.ne1.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,? All,


I have tested crashme on Marvell PXA920 processor with kernel 3.5-rc6.? System will hang 
during testing. 
Sometimes, the board could be connected by JTAG.? I found the?vector_dabt(address 0xFFFF0010) have been
modified. The instruction 
should be a jump instruction. But it have been modified to "BKPT 0x1"? or "Undefined".
The Vector modification doesn't? happen every time when testing.? 


Have anyone encountered with this status ?? Why arm vector is modified?
Thanks in advance.

BR,
Luffy
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120803/c3eac795/attachment.html>
