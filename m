From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 5 May 2017 10:44:59 +0100
Subject: [PATCH v6 11/24] KVM: arm64: vgic-its: Interpret MAPD Size field
 and check related errors
In-Reply-To: <1493898284-29504-12-git-send-email-eric.auger@redhat.com>
References: <1493898284-29504-1-git-send-email-eric.auger@redhat.com>
 <1493898284-29504-12-git-send-email-eric.auger@redhat.com>
Message-ID: <ffba5954-20c4-e482-5be0-df90646429b5@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/05/17 12:44, Eric Auger wrote:
> Up to now the MAPD's ITT size field has been ignored. It encodes
> the number of eventid bit minus 1. It should be used to check
> the eventid when a MAPTI command is issued on a device. Let's
> store the number of eventid bits in the its_device and do the
> check on MAPTI. Also make sure the ITT size field does
> not exceed the GITS_TYPER IDBITS field.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Reviewed-by: Christoffer Dall <cdall@linaro.org>

Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
