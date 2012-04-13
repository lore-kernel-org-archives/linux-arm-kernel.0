From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 13 Apr 2012 09:37:01 +0100
Subject: linux-next: "amba: Remove AMBA level regulator support" commit.
In-Reply-To: <20120413012230.GA30438@windriver.com>
References: <20120413012230.GA30438@windriver.com>
Message-ID: <20120413083700.GB3168@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 12, 2012 at 09:22:31PM -0400, Paul Gortmaker wrote:

> is pointed at by git bisect for the u8500_defconfig build failure:

> If, like my earlier mail this week, this is something you've already
> fixed, then please provide me a link, and I'll gladly include that in
> the triage report, so you don't get needless extra mails about it.

Not me, but Linus W has a patch.  No idea about a link off the top of my
head, google should turn something up I guess.  It's exactly the same
sort of implicit header dependency issue that your cleanups keep
triggering.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120413/9f2a6a67/attachment.sig>
