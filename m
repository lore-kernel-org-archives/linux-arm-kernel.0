From: valmikibow@gmail.com (valmiki)
Date: Sun, 3 Jul 2016 14:58:45 +0000 (UTC)
Subject: Performance mesaurement over pcie inconsistent
Message-ID: <loom.20160703T165818-559@post.gmane.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Im trying to measure DMA performance over pcie. We dont have any counters 
in our hardware which shows per second data rate values. 
I'm trying to measure performance by taking kernel timestamps using 
ktime_get(), but for transferring 'n' bytes data i'm always getting 
inconsistent time difference, im taking timestamps before and after 
transferring data(latter timestamp taken when transfer complete interrupt 
comes). 

Is is good method to measure performance with software timestamps ? 
I need help in what would be better way to measure performance when we 
dont have hardware counters. 

what are the kernel provided better timestamping calls other that 
ktime_get and do_gettimeoftheday, which are more stable ?


Thanks & Regards,
Valmiki     
