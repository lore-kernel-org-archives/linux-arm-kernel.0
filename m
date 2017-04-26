From: bjsprakash.linux@gmail.com (Prakash B)
Date: Wed, 26 Apr 2017 16:59:52 +0530
Subject: [PATCH v5 13/22] KVM: arm64: vgic-its: Check the device id
 matches TYPER DEVBITS range
In-Reply-To: <1492164934-988-14-git-send-email-eric.auger@redhat.com>
References: <1492164934-988-1-git-send-email-eric.auger@redhat.com>
 <1492164934-988-14-git-send-email-eric.auger@redhat.com>
Message-ID: <CACJhumfcvzq0U7TJzqQJtZ5=FWCbNXqDGZMRQgy4VZQtA2D0nQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 14, 2017 at 3:45 PM, Eric Auger <eric.auger@redhat.com> wrote:
> On MAPD we currently check the device id can be stored in the device table.
> Let's first check it can be encoded within the range defined by TYPER
> DEVBITS.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Prakash, Brahmajyosyula <Brahmajyosyula.Prakash@cavium.com>
