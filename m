From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 06 Jun 2017 10:18:11 +0100
Subject: [PATCH] arm64: dts: marvell: 8040-mcbin: Enable 1GB Ethernet
In-Reply-To: <20170606110603.2dafb7ed@free-electrons.com> (Thomas Petazzoni's
 message of "Tue, 6 Jun 2017 11:06:03 +0200")
References: <20170605200107.7692-1-marc.zyngier@arm.com>
 <20170606110234.239d2c4a@free-electrons.com>
 <20170606110603.2dafb7ed@free-electrons.com>
Message-ID: <87h8ztjwz0.fsf@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 06 2017 at 11:06:03 am BST, Thomas Petazzoni <thomas.petazzoni@free-electrons.com> wrote:
> Hello,
>
> On Tue, 6 Jun 2017 11:02:34 +0200, Thomas Petazzoni wrote:
>
>> This patch is somewhat redundant with
>> https://patchwork.kernel.org/patch/9728207/, which despite the flaming
>> discussion that followed, does the same thing (and more).
>
> That being said, the patch from Marcin was also enabling SDHCI, which
> has already been enabled in the mean time by a patch from Russell.
>
> So perhaps we should indeed keep Marc's patch, enabling just the 1GB
> Ethernet interface.

Whichever patch we merge, Andrew's comment remains. Should we stick with
"phy", or switch to "phy-handle" everywhere?

Thanks,

	M.
-- 
Jazz is not dead, it just smell funny.
