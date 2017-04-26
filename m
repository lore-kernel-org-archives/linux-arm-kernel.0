From: bjsprakash.linux@gmail.com (Prakash B)
Date: Wed, 26 Apr 2017 16:51:16 +0530
Subject: [PATCH v5 03/22] KVM: arm/arm64: vgic-its: rename itte into ite
In-Reply-To: <1492164934-988-4-git-send-email-eric.auger@redhat.com>
References: <1492164934-988-1-git-send-email-eric.auger@redhat.com>
 <1492164934-988-4-git-send-email-eric.auger@redhat.com>
Message-ID: <CACJhumdVDUrBGA-e72A1h-Z=d+S81MJtZmTzg2i1=f-yKMLtFQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 14, 2017 at 3:45 PM, Eric Auger <eric.auger@redhat.com> wrote:
> The actual abbreviation for the interrupt translation table entry
> is ITE. Let's rename all itte instances by ite.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>

Tested-by: Prakash, Brahmajyosyula <Brahmajyosyula.Prakash@cavium.com>
