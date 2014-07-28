From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 28 Jul 2014 10:30:42 -0400
Subject: [PATCH 2/2] V4 ARM: mvebu: Added dts defintion for Lenovo
 Iomega ix4-300d NAS
In-Reply-To: <02CE8576-5CD8-4AA5-971E-85CBC8CE05D3@perenite.com>
References: <1406503839-4662-1-git-send-email-yahoo@perenite.com>
 <20140728140805.GQ23220@titan.lakedaemon.net>
 <02CE8576-5CD8-4AA5-971E-85CBC8CE05D3@perenite.com>
Message-ID: <20140728143042.GS23220@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Benoit,

On Mon, Jul 28, 2014 at 04:13:59PM +0200, Benoit Masson wrote:
> Just one question is how would you link this patch to the quirk a0
> patch since this patch can't work without it ...

Even though both patches are needed to boot successfully, there is no
dependency between them in order to compile.  So, they will live in
separate branches until those branches get merged together in a final
release.

The code changes will be applied as a fix to v3.16, and the dts change
will, hopefully, make it in to v3.17.  Where v3.17 will already contain
the code fixes.

thx,

Jason.
