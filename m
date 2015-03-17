From: arun.ramamurthy@broadcom.com (Arun Ramamurthy)
Date: Tue, 17 Mar 2015 14:44:39 -0700
Subject: Setting reboot type at run time for ARM
Message-ID: <5508A047.7060308@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello

I would like to specify a reset type just before issuing the reboot 
command in the kernel. I know the kernel command line parameter can be 
set as "reboot=w" to indicate warm reset but I want to be able to decide 
this at run time before issuing a reboot command. What would be the best 
way to implement this? Modify the reboot command
to accept a parameter or is there a standard hook I can use?

Arun Ramamurthy
