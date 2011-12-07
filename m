From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 7 Dec 2011 12:35:00 +0000
Subject: [PATCH 1/3] PM: Provide an always on power domain governor
In-Reply-To: <201112062239.57001.rjw@sisk.pl>
References: <1322765339-29879-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <20111205001500.GA10173@opensource.wolfsonmicro.com>
 <02d601ccb400$a19380e0$e4ba82a0$%kim@samsung.com>
 <201112062239.57001.rjw@sisk.pl>
Message-ID: <20111207123459.GB18715@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 06, 2011 at 10:39:56PM +0100, Rafael J. Wysocki wrote:
> On Tuesday, December 06, 2011, Kukjin Kim wrote:

> > Rafael, please let me know the branch when you create it so that I can merge
> > it into Samsung tree to avoid other conflicts.

> I need an ack from Magnus or Paul on the shmobile patch. When I get one, I'll
> put patches [1/3] and [2/3] (new version) into my linux-next branch and then
> (after a few days spent in linux-next) to the pm-domains branch.  I'll let you
> know when that happens.

Well, I guess you could put patch 1 and 3 in then add 2 if an ack is
forthcoming for that - there's no direct dependency.
