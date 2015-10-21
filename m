From: santosh.shilimkar@oracle.com (santosh shilimkar)
Date: Tue, 20 Oct 2015 18:26:20 -0700
Subject: [PATCH 1/5] ARM: Keystone: Enable PINCTRL for Keystone ARCH
In-Reply-To: <1445377809-12516-1-git-send-email-fcooper@ti.com>
References: <1445377809-12516-1-git-send-email-fcooper@ti.com>
Message-ID: <5626E9BC.40300@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/20/2015 2:50 PM, Franklin S Cooper Jr wrote:
> From: Franklin Cooper <fcooper@ti.com>
>
> Unlike other Keystone 2 devices, newer Keystone 2 SOCs may utilize
> pinmuxing which requires PINCTRL to be enabled. Therefore, enable
> PINCTRL for all Keystone 2 devices.
>
> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
> ---
>   arch/arm/mach-keystone/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
>
I would be happy to add this one when I see pin
control data in DTS and its actually going to be
used in upstream kernel. Till then I don't want
to add this one.

Regards,
Santosh
