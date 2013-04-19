From: pawel.moll@arm.com (Pawel Moll)
Date: Fri, 19 Apr 2013 10:47:56 +0100
Subject: linux-next: manual merge of the clk tree with the arm-soc tree
In-Reply-To: <20130419172753.0e604e9bad0b7a26a8b52787@canb.auug.org.au>
References: <20130419172753.0e604e9bad0b7a26a8b52787@canb.auug.org.au>
Message-ID: <1366364876.3077.51.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2013-04-19 at 08:27 +0100, Stephen Rothwell wrote:
> Hi Mike,
> 
> Today's linux-next merge of the clk tree got a conflict in
> arch/arm/mach-vexpress/v2m.c between commit dabfd8fb84ab ("ARM: vexpress:
> remove sp804 OF init") from the arm-soc tree and commit 6e973d2c4385
> ("clk: vexpress: Add separate SP810 driver") from the clk tree.
> 
> I fixed it up (I thnk - see below) and can carry the fix as necessary (no
> action is required).

Yep, this merge is fine, thanks!

Pawe?
