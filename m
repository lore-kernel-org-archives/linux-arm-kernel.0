From: santosh.shilimkar@oracle.com (Santosh Shilimkar)
Date: Thu, 2 Jun 2016 11:08:52 -0700
Subject: [PATCH v1 1/2] ARM: dts: keystone: remove bogus IO resource entry
 from PCI binding
In-Reply-To: <1464880672-15203-1-git-send-email-m-karicheri2@ti.com>
References: <1464880672-15203-1-git-send-email-m-karicheri2@ti.com>
Message-ID: <bdf18787-46ed-cc15-8914-fc14a3557681@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/2/2016 8:17 AM, Murali Karicheri wrote:
> The PCI DT bindings contain a bogus entry for IO space which is not
> supported on Keystone. The current bogus entry has an invalid size
> and throws following error during boot.
>
> [0.420713] keystone-pcie 21021000.pcie: error -22: failed to map
>            resource [io  0x0000-0x400000003fff]
>
> So remove it from the dts. While at it also add a bus-range
> value that eliminates following log at boot up.
>
> [0.420659] No bus range found for /soc/pcie at 21020000, using [bus 00-ff]
>
> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
> ---
Both 1/2 and 2/2 looks fine to me. Will queue them for
next merge window.

Regards,
Santosh
