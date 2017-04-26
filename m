From: bjsprakash.linux@gmail.com (Prakash B)
Date: Wed, 26 Apr 2017 16:59:21 +0530
Subject: [PATCH v5 12/22] KVM: arm64: vgic-its: Interpret MAPD ITT_addr
 field
In-Reply-To: <1492164934-988-13-git-send-email-eric.auger@redhat.com>
References: <1492164934-988-1-git-send-email-eric.auger@redhat.com>
 <1492164934-988-13-git-send-email-eric.auger@redhat.com>
Message-ID: <CACJhumcFoahO30Of-64mHo34f7n4gww-rkXHdLDohUqeV4ZcvA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 14, 2017 at 3:45 PM, Eric Auger <eric.auger@redhat.com> wrote:
> Up to now the MAPD ITT_addr had been ignored. We will need it
> for save/restore. Let's record it in the its_device struct.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Prakash, Brahmajyosyula <Brahmajyosyula.Prakash@cavium.com>
