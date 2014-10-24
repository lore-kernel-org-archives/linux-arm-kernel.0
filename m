From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 24 Oct 2014 11:10:15 +0100
Subject: [PATCH 1/2] arm: hwcap: add new hwcap for identifying PXN bits
In-Reply-To: <1414144655-25204-1-git-send-email-js07.lee@gmail.com>
References: <1414144655-25204-1-git-send-email-js07.lee@gmail.com>
Message-ID: <20141024101015.GO27405@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 24, 2014 at 06:57:34PM +0900, Jungseung Lee wrote:
> Modern ARMv7-A/R cores can optionally implement below new
> hardware feature:
> 
> - PXN:
> Privileged execute-never(PXN) is a security feature. PXN bit
> determines whether the processor can execute software from
> the region. This is effective solution against ret2usr attack.
> 
> This patch adds new HWCAP defines to describe new feature.
> On an implementation that does not include the LPAE, PXN is
> optionally supported.

Why does userspace need to know about this?

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
