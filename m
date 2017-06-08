From: john.garry@huawei.com (John Garry)
Date: Thu, 8 Jun 2017 10:04:11 +0100
Subject: [PATCH v3 0/2] acpi/iort, numa: Add numa node mapping for smmuv3
 devices
In-Reply-To: <1496897059-8272-1-git-send-email-ganapatrao.kulkarni@cavium.com>
References: <1496897059-8272-1-git-send-email-ganapatrao.kulkarni@cavium.com>
Message-ID: <a871e365-0a72-535d-7919-769c7428364e@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/06/2017 05:44, Ganapatrao Kulkarni wrote:
> ARM IORT specification(rev. C) has added  provision to define proximity
> domain in SMMUv3 IORT table. Adding required code to parse Proximity
> domain and set numa_node of smmv3 platform devices.
>
> v3:
>   - Addressed Lorenzo Pieralisi comment.
>
> v2:
>   - Changed as per Lorenzo Pieralisi and Hanjun Guo suggestions.
>
> v1:
>   - Initial patch
>
> Ganapatrao Kulkarni (2):
>   acpica: iort: Update SMMUv3 header for proximity domain mapping
>   acpi/iort: numa: Add numa node mapping for smmuv3 devices
>
>  drivers/acpi/arm64/iort.c | 28 ++++++++++++++++++++++++++--
>  include/acpi/actbl2.h     |  4 ++++
>  2 files changed, 30 insertions(+), 2 deletions(-)
>

We'll try and test this in the next day or so.

John
