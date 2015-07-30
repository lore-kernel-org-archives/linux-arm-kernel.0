From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 30 Jul 2015 14:29:32 +0100
Subject: arch/arm/kernel/setup.c does not compile at -O0
In-Reply-To: <55BA1E62.9080103@free.fr>
References: <55BA1E62.9080103@free.fr>
Message-ID: <20150730132932.GR7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 30, 2015 at 02:53:54PM +0200, Mason wrote:
> Is compiling at -O0 not supported?

Much of the kernel does not support building at -O0.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
