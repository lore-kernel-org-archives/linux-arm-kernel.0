From: stigge@antcom.de (Roland Stigge)
Date: Thu, 23 Feb 2012 22:05:10 +0100
Subject: [PATCH v2] USB: Support for LPC32xx SoC
In-Reply-To: <1330030639-3796-1-git-send-email-stigge@antcom.de>
References: <1330030639-3796-1-git-send-email-stigge@antcom.de>
Message-ID: <4F46AA06.30502@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/02/12 21:57, Roland Stigge wrote:
> This patch adds OHCI support to the LPC32xx ARM platform

To get rid of the remaining #ifdefs, I could as well create a new
ohci-lpc32xx.c instead of abusing ohci-pnx4008.c. Would this be the way
to go or are there any other suggestions?

Thanks in advance,

Roland
