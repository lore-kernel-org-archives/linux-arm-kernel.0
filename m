From: broonie@kernel.org (Mark Brown)
Date: Thu, 23 Jan 2014 12:25:19 +0000
Subject: [PATCH v3 7/7] ARM: brcmstb: dts: add a reference DTS for
 Broadcom 7445
In-Reply-To: <52E0D9AD.1040409@monstr.eu>
References: <1389743333-16741-1-git-send-email-marc.ceeeee@gmail.com>
 <201401161219.01038.arnd@arndb.de>
 <20140116134732.GB17314@sirena.org.uk>
 <201401171804.30572.arnd@arndb.de> <52E0D9AD.1040409@monstr.eu>
Message-ID: <20140123122519.GI17314@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 23, 2014 at 09:58:21AM +0100, Michal Simek wrote:
> On 01/17/2014 06:04 PM, Arnd Bergmann wrote:

> >> I thought the solution with deferring registration of the resource for
> >> dev_get_regmap() until a proper device materialised seemed simple and
> >> enough, did you folks run into any problems with that?  I had assumed a
> >> patch was likely to materialise so wasn't worrying about it myself.

> > I'm still hoping that Michal will do that patch.

> And what was the resolution/recommendation how to do it?

Split the regmap creation so the managed resource registration could be
done later on with an already allocated regmap instead of requiring it
to be done at creation time.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140123/722a9d1b/attachment-0001.sig>
