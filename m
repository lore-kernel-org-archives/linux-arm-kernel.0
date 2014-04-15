From: wuqixuan@huawei.com (Wuqixuan)
Date: Tue, 15 Apr 2014 12:54:29 +0000
Subject: Help for doubt about why update SCTLR by cr_alignment every
 syscall,IRQ,exception ?
In-Reply-To: <20140413192930.GE24070@n2100.arm.linux.org.uk>
References: <BB7C62C2B0732E4DA93834A501E846456C8F15D9@szxema505-mbx.china.huawei.com>,
 <20140413192930.GE24070@n2100.arm.linux.org.uk>
Message-ID: <BB7C62C2B0732E4DA93834A501E846456C8F1825@szxema505-mbx.china.huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 14, 2014 at 03:30:00AM +0000, Russell King wrote:

>> Second question is important for us, because the instruction of
>> updation is too slow(about 100 cycles) in our chip, we want to remove
>> the updation instruction for low latency reason, so need your opinion.

> What about it is slow - is the 100 cycles from the mcr itself?

Yes, in our ARMv7 Cortex A15 SOC, only single mcr instruction need 
about 100 cycles, so we want to remove it. 
Can you help to give some idea about the risk to remove it ? 

Regards and Thanks  a lot.
Wuqixuan
