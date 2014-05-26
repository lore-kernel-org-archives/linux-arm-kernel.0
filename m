From: broonie@kernel.org (Mark Brown)
Date: Mon, 26 May 2014 19:17:34 +0100
Subject: [PATCH v2 5/5] regulator: axp20x: resolve self dependency issue
In-Reply-To: <53837298.5080705@free-electrons.com>
References: <1401116292-24066-1-git-send-email-boris.brezillon@free-electrons.com>
 <1401116292-24066-6-git-send-email-boris.brezillon@free-electrons.com>
 <20140526154356.GZ22111@sirena.org.uk>
 <53837298.5080705@free-electrons.com>
Message-ID: <20140526181734.GI12304@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 26, 2014 at 06:58:00PM +0200, Boris BREZILLON wrote:

> AFAIU, we could factorize it by the mean of an helper function (say
> devm_regulators_register), which would take a matches table and a
> regulator desc table and do pretty much what I'm doing in this patch.

> Is that what you had in mind ?

Yes.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140526/471e35e4/attachment.sig>
