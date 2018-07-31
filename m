From: andreas@kemnade.info (Andreas Kemnade)
Date: Tue, 31 Jul 2018 07:28:21 +0200
Subject: [PATCH v3] pwm: pwm-omap-dmtimer: return -EPROBE_DEFER if no
 dmtimer platform data
In-Reply-To: <20180730223030.10628-1-drivshin@awxrd.com>
References: <20180730223030.10628-1-drivshin@awxrd.com>
Message-ID: <20180731072803.61d364db@kemnade.info>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, 30 Jul 2018 18:30:30 -0400
David Rivshin <drivshin@awxrd.com> wrote:

> From: David Rivshin <DRivshin@allworx.com>
> 
> If a pwm-omap-dmtimer is probed before the dmtimer it uses, the platform
> data won't be set yet.
> 
you can of course have my Tested-by:
The version without message runs without trouble in daily use
here on top of 4.17.10. Did also some testing on 4.18-rc7 and I also tested this version. 

I personally have no strange feeling about what dev_XXX() you have.
I hope not too many other developers spend time to fix this just to find out
that something like this is already in review queue.

Regards,
Andreas
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 833 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180731/33e3b4e5/attachment.sig>
