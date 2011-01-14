From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 14 Jan 2011 22:44:39 +0000
Subject: mmci: U300 "sync with blockend" broken for multi-block?
In-Reply-To: <AANLkTim4J8xrj9axhsu4=_7YkEy_ndiJ6cjDNf2WfzEg@mail.gmail.com>
References: <AANLkTimYb6TxLj4SamxRwUgykf9JyW5y9gbejOUXqZ7K@mail.gmail.com>
	<20110101121048.GB25924@n2100.arm.linux.org.uk>
	<AANLkTi=4SrxX-oCx-XXd+oib64j8RhMLdsQD1oWGxgU1@mail.gmail.com>
	<20110105164344.GD8638@n2100.arm.linux.org.uk>
	<AANLkTim4J8xrj9axhsu4=_7YkEy_ndiJ6cjDNf2WfzEg@mail.gmail.com>
Message-ID: <20110114224439.GR15996@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 14, 2011 at 09:13:05PM +0100, Linus Walleij wrote:
> 2011/1/5 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> 
> > Any chance of pr_debug'ing the complete status register each time you
> > service an interrupt? ?You'll probably need to set the kernel log
> > buffer fairly large to ensure that you capture everything.
> 
> I did this test now.

Just to complete the picture, can I see the patch between the version
which produced this and mainline?
