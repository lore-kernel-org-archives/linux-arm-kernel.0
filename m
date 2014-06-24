From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 24 Jun 2014 16:00:36 -0400
Subject: [PATCH v3 3/7] irqchip: atmel-aic: add new atmel AIC driver
In-Reply-To: <53A9A3E3.5020409@free-electrons.com>
References: <1403276487-8792-1-git-send-email-boris.brezillon@free-electrons.com>
 <1403276487-8792-4-git-send-email-boris.brezillon@free-electrons.com>
 <53A74316.5080509@free-electrons.com>
 <20140624125653.GN10202@titan.lakedaemon.net>
 <53A9A3E3.5020409@free-electrons.com>
Message-ID: <20140624200036.GP10202@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 24, 2014 at 06:14:27PM +0200, Boris BREZILLON wrote:
> On 24/06/2014 14:56, Jason Cooper wrote:
...
> > Once you post the new series, I assume it's ok to apply patches 1-3 to
> > irqchip/core, or are there some dependency considerations?
> 
> Patches 6 and 7 depend on the 3 first patches, but we should be able to
> merge them through the at91/arm-soc tree (Nicolas might have to rebase
> its tree for 3.17 on irqchip/core after you have applied patches 1-3).

I'll create a topic branch for you when the time comes.  That way
arm-soc doesn't have to pull in any code it doesn't actually need (helps
with for-next testing).

Please give me a gentle reminder in the coverletter or comments when you
send the next version.

> Anyway, I'd like to wait for at91 maintainers/developers reviews before
> posting a new version.

Sure.

thx,

Jason.
