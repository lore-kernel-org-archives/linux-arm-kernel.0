From: olof@lixom.net (Olof Johansson)
Date: Thu, 20 Dec 2012 11:56:59 -0800
Subject: [PATCH] ARM: dts: fix split memory bank for SSDK5440
In-Reply-To: <1356030217-5472-1-git-send-email-kgene.kim@samsung.com>
References: <1356030217-5472-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <CAOesGMg03Yn=fDr1XqmbBUs=eZO0_8=iti1LUiJ6CX5n1Bm45g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Dec 20, 2012 at 11:03 AM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> The size of memory bank should be under 256MB, because current
> section size is 256MB on EXYNOS SoCs. This patch fixes it.

This makes no sense. You don't have to split up memory ranges, the
code should be made to handle it instead.

What's the actual bug caused by this? The description is vague.


-Olof
