From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Fri, 16 Nov 2018 13:49:24 +0100
Subject: [PATCH 9/9] ARM: EXYNOS: remove <mach/map.h> include
In-Reply-To: <1542294698-17470-10-git-send-email-b.zolnierkie@samsung.com>
References: <CGME20181115151247epcas2p4053da2cb28b2414156d2fd0530059c0d@epcas2p4.samsung.com>
 <1542294698-17470-1-git-send-email-b.zolnierkie@samsung.com>
 <1542294698-17470-10-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <CAJKOXPco4yCmCH=RC3Kdoo-x1UPFj2GeGDp6Eb0zZ-DkNg013w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 15 Nov 2018 at 16:12, Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:
>
> Remove no longer needed <mach/map.h> include.

If I understand correctly, header is not needed because of previous
commit so it should be squashed there.

Best regards,
Krzysztof
