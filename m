From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 18 Dec 2012 11:38:20 +0100
Subject: [PATCH] ARM: realview: fix private peripheral memory base for EB
 rev. B boards
In-Reply-To: <50D044B0.1000208@arm.com>
References: <1355760668-28606-1-git-send-email-will.deacon@arm.com>
 <50D044B0.1000208@arm.com>
Message-ID: <ec164a3ea61f0bf28c5637aaf46c4c89@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 18 Dec 2012 10:25:52 +0000, Marc Zyngier <marc.zyngier@arm.com>
wrote:
> On 17/12/12 16:11, Will Deacon wrote:
>> Commit 34ae6c96a6a7 ("ARM: 7298/1: realview: fix mapping of MPCore
>> private memory region") accidentally broke the definition for the base
>> address of the private peripheral region on revision B Realview-EB
>> boards.
>> 
>> This patch uses the correct address for REALVIEW_EB11MP_PRIV_MEM_BASE.
>> 
>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>> Tested-by: Florian Fainelli <florian@openwrt.org>
>> Signed-off-by: Will Deacon <will.deacon@arm.com>
> 
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>

The ARM email server seems to be acting up. Sorry for the noise.

        M.
-- 
Fast, cheap, reliable. Pick two.
