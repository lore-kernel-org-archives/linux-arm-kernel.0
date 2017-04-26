From: bjsprakash.linux@gmail.com (Prakash B)
Date: Wed, 26 Apr 2017 17:01:56 +0530
Subject: [PATCH v5 15/22] KVM: arm64: vgic-its: vgic_its_alloc_ite/device
In-Reply-To: <1492164934-988-16-git-send-email-eric.auger@redhat.com>
References: <1492164934-988-1-git-send-email-eric.auger@redhat.com>
 <1492164934-988-16-git-send-email-eric.auger@redhat.com>
Message-ID: <CACJhumeXYoo-wfOu5fRWV1q-fh0B3-A2igtP_FeC_Ho4f-=qvA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 14, 2017 at 3:45 PM, Eric Auger <eric.auger@redhat.com> wrote:
> Add two new helpers to allocate an its ite and an its device.
> This will avoid duplication on restore path.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Tested-by: Prakash, Brahmajyosyula <Brahmajyosyula.Prakash@cavium.com>
