From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Wed, 09 Jul 2014 12:18:30 +0200
Subject: [PATCH 3/3] arm: dts: dra7: fixup qspi entry
In-Reply-To: <53BD1444.6080603@ti.com>
References: <1404844852-19980-1-git-send-email-bigeasy@linutronix.de>
 <1404844852-19980-3-git-send-email-bigeasy@linutronix.de>
 <53BD1444.6080603@ti.com>
Message-ID: <53BD16F6.1030006@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/09/2014 12:07 PM, sourav wrote:
> Hi,

Hello, Sourav,

> The number is correct and is complaining just because the crossbar stuff
> is not
> put in. I had already posted a patch[1] to remove interrupt binding as
> of now.
> 
> Hence, NAK for this patch.

Thank you for explanation. What is the status on the crossbar stuff? Is
this comming any time soon? It seems that it is also stalling the
networking pieces.

> 
> [1]: https://patchwork.kernel.org/patch/4364341/

Sebastian
