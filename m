From: bjsprakash.linux@gmail.com (Prakash B)
Date: Wed, 26 Apr 2017 17:04:03 +0530
Subject: [PATCH v5 19/22] KVM: arm64: vgic-its: ITT save and restore
In-Reply-To: <1492164934-988-20-git-send-email-eric.auger@redhat.com>
References: <1492164934-988-1-git-send-email-eric.auger@redhat.com>
 <1492164934-988-20-git-send-email-eric.auger@redhat.com>
Message-ID: <CACJhumf28Xamj187sT+2mSKcptBaT0tRDZV7di+F9m0-fKTejA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 14, 2017 at 3:45 PM, Eric Auger <eric.auger@redhat.com> wrote:
> Introduce routines to save and restore device ITT and their
> interrupt table entries (ITE).
>
> The routines will be called on device table save and
> restore. They will become static in subsequent patches.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Prakash, Brahmajyosyula <Brahmajyosyula.Prakash@cavium.com>
