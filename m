From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 22 Jan 2014 00:12:56 +0100
Subject: [PATCH v2 1/2] dmaengine: add Qualcomm BAM dma driver
In-Reply-To: <20140121230103.GA3554@qualcomm.com>
References: <1389380874-22753-1-git-send-email-agross@codeaurora.org>
 <5548936.L46nLkuVIz@wuerfel> <20140121230103.GA3554@qualcomm.com>
Message-ID: <3380039.pmsbzceqbf@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 21 January 2014 17:01:03 Andy Gross wrote:
> 
> Thanks for the clarification.  I think I'll probably do:
> ARCH_MSM_DT || (COMPILE_TEST && ARM)
> 
> The latter due to my use of writel_relaxed.

Yes, looks good.

	Arnd
