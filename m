From: davem@davemloft.net (David Miller)
Date: Sat, 13 Feb 2016 06:03:14 -0500 (EST)
Subject: [PATCH v3 net 0/7] mvneta fixes for SMP
In-Reply-To: <1454620169-8156-1-git-send-email-gregory.clement@free-electrons.com>
References: <1454620169-8156-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20160213.060314.257506721983765240.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Date: Thu,  4 Feb 2016 22:09:22 +0100

> Following this bug report:
> http://thread.gmane.org/gmane.linux.ports.arm.kernel/468173 and the
> suggestions from Russell King, I reviewed all the code involving
> multi-CPU. It ended with this series of patches which should improve
> the stability of the driver.
> 
> During my test I found another bug which is fixed by new patch (the
> second one of this new version of the series)
> 
> The two first patches fix real bugs, the others fix potential issues
> in the driver.

Series applied, thanks.
