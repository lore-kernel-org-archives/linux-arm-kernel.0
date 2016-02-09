From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 9 Feb 2016 19:42:07 +0100
Subject: [PATCH v2 03/28] ARM: KVM: Move VFP registers to a CPU context
 structure
In-Reply-To: <1454583645-10144-4-git-send-email-marc.zyngier@arm.com>
References: <1454583645-10144-1-git-send-email-marc.zyngier@arm.com>
 <1454583645-10144-4-git-send-email-marc.zyngier@arm.com>
Message-ID: <20160209184207.GH5171@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 04, 2016 at 11:00:20AM +0000, Marc Zyngier wrote:
> In order to turn the WS code into something that looks a bit
> more like the arm64 version, move the VFP registers into a
> CPU context container for both the host and the guest.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
