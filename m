From: vapier@gentoo.org (Mike Frysinger)
Date: Mon, 11 Jul 2011 00:30:04 -0400
Subject: [PATCH 0/6] clk: Initial feedback for off-SoC slow bus clocks
In-Reply-To: <20110711035732.GA5040@opensource.wolfsonmicro.com>
References: <20110711025344.GA27497@opensource.wolfsonmicro.com>
	<20110711035732.GA5040@opensource.wolfsonmicro.com>
Message-ID: <201107110030.06399.vapier@gentoo.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday, July 10, 2011 23:57:40 Mark Brown wrote:
> On Mon, Jul 11, 2011 at 11:53:44AM +0900, Mark Brown wrote:
> 
> Linus, CCing you in as apparently you're taking over the clock API work.
> Do you need me to forward all the patches to you?

along these lines, i dont think the new people on the cc noticed my earlier e-
mail:
for future series, could you cc uclinux-dist-devel at blackfin.uclinux.org ?  we 
dont do clock management on Blackfin parts atm, but it's something we would 
like to start doing.  our hardware can easily benefit from this.
-mike
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110711/69b913bf/attachment.sig>
