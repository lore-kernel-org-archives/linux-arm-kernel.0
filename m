From: broonie@kernel.org (Mark Brown)
Date: Thu, 5 Mar 2015 17:56:51 +0000
Subject: [PATCH] regulator: wm8350: remove unused variable
In-Reply-To: <2131808.TgSGZRWdu2@wuerfel>
References: <2131808.TgSGZRWdu2@wuerfel>
Message-ID: <20150305175651.GD21293@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 26, 2015 at 11:29:29AM +0100, Arnd Bergmann wrote:
> After the only user of the variable has been removed, we get a valid gcc
> warning about it:

I applied another fix for this, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150305/748702c4/attachment.sig>
