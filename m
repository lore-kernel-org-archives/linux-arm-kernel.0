From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sun, 07 May 2017 13:01:20 +0100
Subject: [PATCH v7 13/24] KVM: arm64: vgic-its: Check the device id
 matches TYPER DEVBITS range
In-Reply-To: <1494084283-12723-14-git-send-email-eric.auger@redhat.com> (Eric
 Auger's message of "Sat, 6 May 2017 17:24:32 +0200")
References: <1494084283-12723-1-git-send-email-eric.auger@redhat.com>
 <1494084283-12723-14-git-send-email-eric.auger@redhat.com>
Message-ID: <871ss0lvu7.fsf@on-the-bus.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 06 2017 at  4:24:32 pm BST, Eric Auger <eric.auger@redhat.com> wrote:
> On MAPD we currently check the device id can be stored in the device table.
> Let's first check it can be encoded within the range defined by TYPER
> DEVBITS.
>
> Also check the collection ID belongs to the 16 bit range as GITS_TYPER
> CIL field equals to 0.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Reviewed-by: Christoffer Dall <cdall@linaro.org>

Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead, it just smell funny.
