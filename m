From: bjsprakash.linux@gmail.com (Prakash B)
Date: Wed, 26 Apr 2017 17:03:30 +0530
Subject: [PATCH v5 18/22] KVM: arm64: vgic-its: vgic_its_check_id returns
 the entry's GPA
In-Reply-To: <1492164934-988-19-git-send-email-eric.auger@redhat.com>
References: <1492164934-988-1-git-send-email-eric.auger@redhat.com>
 <1492164934-988-19-git-send-email-eric.auger@redhat.com>
Message-ID: <CACJhumd4M+Yv2b0TgyKpQ0hi_mxY4VT11oUaT-s3cT2TxHvzcQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 14, 2017 at 3:45 PM, Eric Auger <eric.auger@redhat.com> wrote:
> As vgic_its_check_id() computes the device/collection entry's
> GPA, let's return it so that new callers can retrieve it easily.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Prakash, Brahmajyosyula <Brahmajyosyula.Prakash@cavium.com>
