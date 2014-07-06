From: robherring2@gmail.com (Rob Herring)
Date: Sun, 6 Jul 2014 10:23:43 -0500
Subject: [PATCH v8 0/9] Support for creating generic PCI host bridges from
 DT
In-Reply-To: <1404240214-9804-1-git-send-email-Liviu.Dudau@arm.com>
References: <1404240214-9804-1-git-send-email-Liviu.Dudau@arm.com>
Message-ID: <CAL_JsqK_CfagmiFOpOXVYGry22nGnCZL0ZXeJhYxb9zp=P2fsQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 1, 2014 at 1:43 PM, Liviu Dudau <Liviu.Dudau@arm.com> wrote:
> This is my resurected attempt at adding support for generic PCI host
> bridge controllers that make use of device tree information to
> configure themselves. I've tagged it as v8 although the patches
> have now been reshuffled in order to ease adoption so referring to
> the older versions might be a bit of a hoop jumping exercise.
>
> Changes from v7:
>   - Reordered the patches so that fixes and non-controversial patches
>     from v7 can be accepted more easily. If agreed I can split the
>     series again into patches that can be upstreamed easily and ones
>     that still need discussion.
>   - Moved the of_create_host_bridge() function to drivers/of/of_pci.c
>     to better reflect its target use.
>   - Added the function to remap the bus I/O resources that used to be
>     provided in my arm64 patch series and (re)named it pci_remap_iospace()
>   - Removed error code checking from parsing and mapping of IRQ from DT
>     in recognition that some PCI devices will not have legacy IRQ mappings.
>
> v7 thread here with all the historic information: https://lkml.org/lkml/2014/3/14/279

Can you publish a branch for this series please.

Rob
