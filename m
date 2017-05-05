From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 5 May 2017 10:45:43 +0100
Subject: [PATCH v6 12/24] KVM: arm64: vgic-its: Interpret MAPD ITT_addr
 field
In-Reply-To: <1493898284-29504-13-git-send-email-eric.auger@redhat.com>
References: <1493898284-29504-1-git-send-email-eric.auger@redhat.com>
 <1493898284-29504-13-git-send-email-eric.auger@redhat.com>
Message-ID: <ce822aeb-7f3e-a330-a68d-c87d23b90a8f@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/05/17 12:44, Eric Auger wrote:
> Up to now the MAPD ITT_addr had been ignored. We will need it
> for save/restore. Let's record it in the its_device struct.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
