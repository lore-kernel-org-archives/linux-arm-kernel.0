From: xiachendong@hotmail.com (Xiachen Dong)
Date: Tue, 22 Jun 2010 15:40:35 -0400
Subject: Possible methods for the kernel to terminate a process
Message-ID: <BAY134-W142753895B5626C329E273BDC40@phx.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

We have a quick question. Besides sending signals, are there any other ways for the kernel to terminate a process?

We have such question because we try to kill a user space process by the shell command kill and we cannot kill it probably because it is in an un-interruptible sleep/wait. 

However, we still wish to be able to kill the user space process under this circumstance. To our knowledge of the kernel, if the kernel wants to kill a process when special event such as exception happens, it usually sends a signal to the process. We really cannot think of any other methods for a kernel to terminate a process.

Can anyone provide some hints on this? Is rebooting the machine the only solution to the problem?

Thanks,

Xiachen

 		 	   		  
_________________________________________________________________
MSN Dating: Find someone special. Start now.
http://go.microsoft.com/?linkid=9734384
