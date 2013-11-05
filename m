From: olof@lixom.net (Olof Johansson)
Date: Tue, 5 Nov 2013 11:47:13 -0800
Subject: [PATCH] ARM: nommu: Implement dummy early_paging_init()
In-Reply-To: <1382533728-19495-1-git-send-email-treding@nvidia.com>
References: <1382533728-19495-1-git-send-email-treding@nvidia.com>
Message-ID: <CAOesGMg0Ah7HoDOiOX+dDYCA3A17-VryiULuUzT-j-BHFyCaOw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 23, 2013 at 6:08 AM, Thierry Reding
<thierry.reding@gmail.com> wrote:
> No-MMU configurations currenty fail to build because they are missing
> the early_paging_init() symbol.
>
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Acked-by: Olof Johansson <olof@lixom.net>

This is still showing up on -next with at91x40_defconfig. Can you feed
it to the patch tracker if you haven't already?


Thanks,

-Olof
