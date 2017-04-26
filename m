From: bjsprakash.linux@gmail.com (Prakash B)
Date: Wed, 26 Apr 2017 17:04:39 +0530
Subject: [PATCH v5 20/22] KVM: arm64: vgic-its: Device table save/restore
In-Reply-To: <1492164934-988-21-git-send-email-eric.auger@redhat.com>
References: <1492164934-988-1-git-send-email-eric.auger@redhat.com>
 <1492164934-988-21-git-send-email-eric.auger@redhat.com>
Message-ID: <CACJhume3UQUzKBAuQcqWPMWCPBG6oayARVBNU7Rwk1yD7CDPKg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 14, 2017 at 3:45 PM, Eric Auger <eric.auger@redhat.com> wrote:
> This patch saves the device table entries into guest RAM.
> Both flat table and 2 stage tables are supported. DeviceId
> indexing is used.
>
> For each device listed in the device table, we also save
> the translation table using the vgic_its_save/restore_itt
> routines.
>
> On restore, devices are re-allocated and their ite are
> re-built.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Prakash, Brahmajyosyula <Brahmajyosyula.Prakash@cavium.com>
