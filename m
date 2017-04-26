From: bjsprakash.linux@gmail.com (Prakash B)
Date: Wed, 26 Apr 2017 16:53:31 +0530
Subject: [PATCH v5 06/22] KVM: arm/arm64: vgic: expose (un)lock_all_vcpus
In-Reply-To: <1492164934-988-7-git-send-email-eric.auger@redhat.com>
References: <1492164934-988-1-git-send-email-eric.auger@redhat.com>
 <1492164934-988-7-git-send-email-eric.auger@redhat.com>
Message-ID: <CACJhume7fHb72Av=v78Whf47szu06Kwara4LYR4Cbdc8WLdjVA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 14, 2017 at 3:45 PM, Eric Auger <eric.auger@redhat.com> wrote:
> We need to use those helpers in vgic-its.c so let's
> expose them in the private vgic header.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Tested-by: Prakash, Brahmajyosyula <Brahmajyosyula.Prakash@cavium.com>
