From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 4 Jul 2012 14:17:50 +0100
Subject: How to handle parameter variation across different boards but
 same platform
In-Reply-To: <1BAFE6F6C881BF42822005164F1491C33EA3532A@DBDE01.ent.ti.com>
References: <1BAFE6F6C881BF42822005164F1491C33EA3532A@DBDE01.ent.ti.com>
Message-ID: <20120704131749.GZ4111@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 04, 2012 at 12:45:03PM +0000, Hebbar, Gururaja wrote:

You should fix your mailer to word wrap at less than 80 columns.

> Using machine_is_xxx() is not sufficient because there are 2 other
> boards on same Platform/machine but with different values.

> So, how to specify these parameters for the new board?

What do you mean by "board"?  If these are plugin modules for your
platform you need to either identify this at runtime and register a
different machine driver or select at compile time.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120704/076061df/attachment-0001.sig>
