From: broonie@kernel.org (Mark Brown)
Date: Thu, 9 Jul 2015 23:05:46 +0100
Subject: [PATCH 3/3] regulator: 88pm800: Add dev_info to show probe
 success status
In-Reply-To: <13146.1436470614@turing-police.cc.vt.edu>
References: <1436445692-10656-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1436445692-10656-4-git-send-email-vaibhav.hiremath@linaro.org>
 <13146.1436470614@turing-police.cc.vt.edu>
Message-ID: <20150709220546.GR11162@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 09, 2015 at 03:36:54PM -0400, Valdis.Kletnieks at vt.edu wrote:
> On Thu, 09 Jul 2015 18:11:32 +0530, Vaibhav Hiremath said:

> > +	dev_info(&pdev->dev, "Regulator registered ...\n");

> In which case this should be 'dev_debug()' or similar so it doesn't
> clutter up and slow down a production boot.

It's not adding anything, there's plenty of debug messages you can turn
on in the core for things like device enumeration.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150709/43924073/attachment.sig>
