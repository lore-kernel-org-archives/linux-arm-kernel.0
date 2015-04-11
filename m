From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 11 Apr 2015 00:13:29 +0000
Subject: [PATCH v5 00/11] ARM: vf610m4: Add Vybrid Cortex-M4 support
In-Reply-To: <1428609855-27657-1-git-send-email-stefan@agner.ch>
References: <1428609855-27657-1-git-send-email-stefan@agner.ch>
Message-ID: <20150411001329.GE18660@io.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stefan,

On Thu, Apr 09, 2015 at 10:04:04PM +0200, Stefan Agner wrote:
> Stefan Agner (11):
>   genirq: generic chip: support hierarchy domain
>   irqchip: nvic: support hierarchy irq domain
>   irqchip: vf610-mscm: support NVIC parent

I've applied patches 1 to 3 onto irqchip/vybrid.  And will merge them in for
-next testing.  We don't know if v4.0 is dropping on Sunday or not.  If
it doesn't, we should be able to get these in for v4.1.  Otherwise,
they'll have to wait for the next cycle.

thx,

Jason.
