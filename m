From: bjsprakash.linux@gmail.com (Prakash B)
Date: Wed, 26 Apr 2017 16:54:53 +0530
Subject: [PATCH v5 08/22] KVM: arm64: vgic-its: Implement
 vgic_mmio_uaccess_write_its_creadr
In-Reply-To: <1492164934-988-9-git-send-email-eric.auger@redhat.com>
References: <1492164934-988-1-git-send-email-eric.auger@redhat.com>
 <1492164934-988-9-git-send-email-eric.auger@redhat.com>
Message-ID: <CACJhumcnS-TS9GL7krxccMEjTwzGPo7y0OgAqbi9WSFXhWv1gw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 14, 2017 at 3:45 PM, Eric Auger <eric.auger@redhat.com> wrote:
> GITS_CREADR needs to be restored so let's implement the associated
> uaccess_write_its callback. The write only is allowed if the its
> is disabled.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

Tested-by: Prakash, Brahmajyosyula <Brahmajyosyula.Prakash@cavium.com>
