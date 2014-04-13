From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 13 Apr 2014 20:29:30 +0100
Subject: Help for doubt about why update SCTLR by cr_alignment every
 syscall,IRQ,exception ?
In-Reply-To: <BB7C62C2B0732E4DA93834A501E846456C8F15D9@szxema505-mbx.china.huawei.com>
References: <BB7C62C2B0732E4DA93834A501E846456C8F15D9@szxema505-mbx.china.huawei.com>
Message-ID: <20140413192930.GE24070@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 08, 2014 at 03:46:38AM +0000, Wuqixuan wrote:
> Second question is important for us, because the instruction of
> updation is too slow(about 100 cycles) in our chip, we want to remove
> the updation instruction for low latency reason, so need your opinion. 

What about it is slow - is the 100 cycles from the mcr itself?

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
