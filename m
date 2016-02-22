From: zajec5@gmail.com (=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=)
Date: Mon, 22 Feb 2016 07:20:37 +0100
Subject: [PATCH] ARM: tegra: add "jedec,spi-nor" flash compatible binding
In-Reply-To: <1439705605-9127-1-git-send-email-zajec5@gmail.com>
References: <1439705605-9127-1-git-send-email-zajec5@gmail.com>
Message-ID: <CACna6rzi2NJW2JL0X4eLJOXDsLyvcsj+piBEbP6LWOUvOfctRw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16 August 2015 at 08:13, Rafa? Mi?ecki <zajec5@gmail.com> wrote:
> Starting with commit 8947e396a829 ("Documentation: dt: mtd: replace
> "nor-jedec" binding with "jedec, spi-nor"") we have "jedec,spi-nor"
> binding indicating support for JEDEC identification.
>
> Use it for all flashes that are supposed to support READ ID op according
> to the datasheets.

Hi, for some reason it seems this patch wasn't applied. I didn't get
any comment and it was sent to all e-mails listed in MAINTAINERS in
TEGRA ARCHITECTURE SUPPORT
which I hope it enough.

Could someone pick it, please? FWIW you can find it in the patchwork:
http://patchwork.ozlabs.org/patch/507676/
