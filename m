From: marek.vasut@gmail.com (Marek Vasut)
Date: Thu, 2 Aug 2012 09:39:50 +0200
Subject: MMAP_MIN_ADDR problem/question
Message-ID: <201208020939.50225.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi guys,

Me and a coleague of mine recently ran into the issue [1]. The problem is, that 
I set mmap_min_addr to 65536, making it unable for "su - user" command to work, 
it crashes with SIGKILL. I now at least see a solution (set it to 32768). Though 
I don't understand why. Can someone please exaplain me why it has to be 32768 an 
not more?

[1] http://ubuntu.5.n6.nabble.com/PATCH-DEFAULT-MMAP-MIN-ADDR-32768-for-arm-
td1604723.html

Thanks in advance!

Best regards,
Marek Vasut
