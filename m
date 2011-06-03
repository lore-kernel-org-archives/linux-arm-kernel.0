From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 3 Jun 2011 08:54:51 +0100
Subject: [PATCH 1/2] clps711x/ceiva: port to use physmap flash
In-Reply-To: <BANLkTimG86aN5hUBy=GgpMAxhiQSPbetPg@mail.gmail.com>
References: <1307015648-17505-1-git-send-email-dbaryshkov@gmail.com>
	<1307075905.4405.130.camel@localhost>
	<BANLkTi=TQfMec9Kuq4-P9Rokp44g67Tx6A@mail.gmail.com>
	<1307077842.4405.133.camel@localhost>
	<BANLkTimG86aN5hUBy=GgpMAxhiQSPbetPg@mail.gmail.com>
Message-ID: <20110603075451.GF10532@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 03, 2011 at 09:17:31AM +0400, Dmitry Eremin-Solenikov wrote:
> Anyway the patch removing mtd support can be pushed via mtd tree
> (there is really no point on mtd/maps/ceiva.c), and removing ceiva
> depends on Russell's decision.

If it's not getting any attention and no one's interested in it then
it can be removed.
