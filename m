From: cornelia.huck@de.ibm.com (Cornelia Huck)
Date: Thu, 9 Jul 2015 14:21:54 +0200
Subject: [PATCH] KVM: Add Kconfig option to signal cross-endian guests
In-Reply-To: <1436428145-29823-1-git-send-email-thuth@redhat.com>
References: <20150707195012-mutt-send-email-mst@redhat.com>
 <1436428145-29823-1-git-send-email-thuth@redhat.com>
Message-ID: <20150709142154.5561fa16.cornelia.huck@de.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu,  9 Jul 2015 09:49:05 +0200
Thomas Huth <thuth@redhat.com> wrote:

> The option for supporting cross-endianness legacy guests in

s/cross-endianness/cross-endian/ ?

> the vhost and tun code should only be available on systems
> that support cross-endian guests.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  arch/arm/kvm/Kconfig     | 1 +
>  arch/arm64/kvm/Kconfig   | 1 +
>  arch/powerpc/kvm/Kconfig | 1 +
>  drivers/net/Kconfig      | 1 +
>  drivers/vhost/Kconfig    | 1 +
>  virt/kvm/Kconfig         | 3 +++
>  6 files changed, 8 insertions(+)

Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
