From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 06 Jun 2017 10:16:08 +0100
Subject: [PATCH] arm64: dts: marvell: 8040-mcbin: Enable 1GB Ethernet
In-Reply-To: <20170606110234.239d2c4a@free-electrons.com> (Thomas Petazzoni's
 message of "Tue, 6 Jun 2017 11:02:34 +0200")
References: <20170605200107.7692-1-marc.zyngier@arm.com>
 <20170606110234.239d2c4a@free-electrons.com>
Message-ID: <87lgp5jx2f.fsf@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 06 2017 at 11:02:34 am BST, Thomas Petazzoni <thomas.petazzoni@free-electrons.com> wrote:
> Hello,
>
> On Mon,  5 Jun 2017 21:01:07 +0100, Marc Zyngier wrote:
>> Enable the 1GB Ethernet interface that lives on the slave CP110,
>> with its corresponding phy (that oddly lives on the master CP110).
>> 
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>
> This patch is somewhat redundant with
> https://patchwork.kernel.org/patch/9728207/, which despite the flaming
> discussion that followed, does the same thing (and more).

It's great that there is a patch for that already. How far is that from
being merged (given how much controversy seem to surround this)?

Thanks,

	
-- 
Jazz is not dead, it just smell funny.
