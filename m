From: nicolas.derouineau@vitec.com (Nicolas Derouineau)
Date: Wed, 6 Aug 2014 14:01:41 +0000
Subject: CPUIdle Armada 370
Message-ID: <1407333701627.99622@vitec.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,
I am currently trying to use the CPUIdle driver provided by linux-next (or by the patch here https://github.com/MISL-EBU-System-SW/mainline-public/commits/3.16/cpuidle-v3). 

Everything runs fine as long as I don't select the CPU driver for the ARMADA Family. When I do, at boottime, the program is entering the __cpu_suspend save function and then get lost in it and that turns into a kernel panic. I have already made a post about this on the ARM Community Forum (http://community.arm.com/thread/6326).

The "faulty" configuration file is attached to this email.

Any help would be appreciated,

Regards,

Nicolas DEROUINEAU

-------------- next part --------------
A non-text attachment was scrubbed...
Name: config_armada_370_cpuidle
Type: application/octet-stream
Size: 60786 bytes
Desc: config_armada_370_cpuidle
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140806/cdfa885b/attachment-0001.obj>
