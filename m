From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 6 Jun 2017 11:19:34 +0200
Subject: [PATCH] arm64: dts: marvell: 8040-mcbin: Enable 1GB Ethernet
In-Reply-To: <87lgp5jx2f.fsf@arm.com>
References: <20170605200107.7692-1-marc.zyngier@arm.com>
 <20170606110234.239d2c4a@free-electrons.com>
 <87lgp5jx2f.fsf@arm.com>
Message-ID: <20170606111934.79c84a0b@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, 06 Jun 2017 10:16:08 +0100, Marc Zyngier wrote:

> > This patch is somewhat redundant with
> > https://patchwork.kernel.org/patch/9728207/, which despite the flaming
> > discussion that followed, does the same thing (and more).  
> 
> It's great that there is a patch for that already. How far is that from
> being merged (given how much controversy seem to surround this)?

As I said in my second reply, I believe a v2 of your patch would in
fact be better.

Marcin's patch is no longer applicable, and was doing too many things
at once. So let's merge your patch instead.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
