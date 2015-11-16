From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 16 Nov 2015 18:05:09 +0100
Subject: [PATCH 3/6] serial: mid8250: select CONFIG_RATIONAL
In-Reply-To: <1447692962.31665.145.camel@linux.intel.com>
References: <1447688894-2936779-1-git-send-email-arnd@arndb.de>
 <1447688894-2936779-4-git-send-email-arnd@arndb.de>
 <1447692962.31665.145.camel@linux.intel.com>
Message-ID: <28108741.gZodRCNg2d@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 16 November 2015 18:56:02 Andy Shevchenko wrote:
> On Mon, 2015-11-16 at 16:48 +0100, Arnd Bergmann wrote:
> > The Intel MID support got split out from the PCI 8250 driver,
> > and that now causes a build error when no other driver selects
> > CONFIG_RATIONAL:
> 
> Already published.
> https://lkml.org/lkml/2015/11/12/272
> 
> It's not first time you send patches that already have been published.
> 
> I think you use some testing automation which doesn't take into
> consideration what is sent in mailing lists.

Correct, it also ignores whatever patches other people have in private
git trees, in their mail clients or in their heads.

I try to send patches for things that break either on the first
day they are broken so mine comes first, or I wait a while to see
if a fix ends up in linux-next to give everyone else a chance to
get their patch into next so I can catch it on a rebase.

	Arnd
