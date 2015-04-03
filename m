From: peter@hurleysoftware.com (Peter Hurley)
Date: Fri, 03 Apr 2015 13:29:44 -0400
Subject: [PATCH v5 10/15] serial: stm32-usart: Add STM32 USART Driver
In-Reply-To: <1428080481-18591-11-git-send-email-mcoquelin.stm32@gmail.com>
References: <1428080481-18591-1-git-send-email-mcoquelin.stm32@gmail.com>
 <1428080481-18591-11-git-send-email-mcoquelin.stm32@gmail.com>
Message-ID: <551ECE08.8040407@hurleysoftware.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/03/2015 01:01 PM, Maxime Coquelin wrote:
> This drivers adds support to the STM32 USART controller, which is a
> standard serial driver.

Reviewed-by: Peter Hurley <peter@hurleysoftware.com>

PS - I saw Rob's comment about 'hw-flow-ctrl' vs 'auto-flow-control'
and I'm ok with either so feel free to and my review comment to a v6
if that's the only change.
