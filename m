From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 28 Jul 2010 10:39:44 +0200
Subject: [PATCH 1/2] arm: msm: Add System MMU support.
In-Reply-To: <1280270466-13503-1-git-send-email-stepanm@codeaurora.org>
References: <1280270466-13503-1-git-send-email-stepanm@codeaurora.org>
Message-ID: <201007281039.44883.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 28 July 2010 00:41:06 Stepan Moskovchenko wrote:
> 
> Add support for the System MMUs found on the 8x60 and 8x72
> families of Qualcomm chips. These SMMUs allow virtualization
> of the address space used by most of the multimedia cores
> on these chips.
> 

How is this different from an IOMMU?

>From a very brief look, it seems that you should be using the
existing dma-mapping APIs here instead of making up your own.

	Arnd
