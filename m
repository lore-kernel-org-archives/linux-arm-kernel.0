From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 15 Mar 2017 14:57:42 -0700
Subject: [PATCH 2/3] ARM: brcmstb: Enable ARCH_HAS_HOLES_MEMORYMODEL
In-Reply-To: <20170309185120.1713-3-f.fainelli@gmail.com>
References: <20170309185120.1713-1-f.fainelli@gmail.com>
Message-ID: <20170315215742.15473-1-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 9 Mar 2017 10:51:19 -0800, Florian Fainelli <f.fainelli@gmail.com> wrote:
> From: Danesh Petigara <danesh.petigara@broadcom.com>
>
> Due to the brcmstb SoC's memory map, we may have holes in the memory if
> we don't populate the maximum amount of memory supported by e.g: the
> first memory controller which spans either the first 1GiB or first 2GiB
> of memory.
>
> We need to select ARCH_HAS_HOLES_MEMORYMODEL in order to enable
> CONFIG_HAVE_ARCH_PFN_VALID on platforms that have CONFIG_SPARSEMEM
> enabled.
>
> Signed-off-by: Danesh Petigara <danesh.petigara@broadcom.com>
> [florian: Detailed commit message]
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---

Applied, thanks!
--
Florian
