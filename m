From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 09 Jan 2015 01:06:56 +0100
Subject: [PATCH 1/2] soc: qcom: Add TCSR driver
In-Reply-To: <1420757577-20425-2-git-send-email-agross@codeaurora.org>
References: <1420757577-20425-1-git-send-email-agross@codeaurora.org>
 <1420757577-20425-2-git-send-email-agross@codeaurora.org>
Message-ID: <4757751.7cLGsvPiZX@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 08 January 2015 16:52:56 Andy Gross wrote:
> This patch adds support for the TCSR (Top Control and Status Register) IP block
> that is present in the Qualcomm IPQ8064, APQ8064, and some later processors.
> This block contains additional configuration and mux settings for various
> peripherals in the system, including the ADM DMA block and USB controller.
> 
> Signed-off-by: Andy Gross <agross@codeaurora.org>
> 

It sounds like this is a collection of random registers. Have you considered
making it a syscon node instead?

	Arnd
