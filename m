From: pullip.cho@samsung.com (KyongHo Cho)
Date: Thu, 12 Apr 2012 17:19:05 +0900
Subject: [PATCH 0/2] Exynos: fix SYSMMU driver to work with power domains
In-Reply-To: <1334154871-4756-1-git-send-email-m.szyprowski@samsung.com>
References: <1334154871-4756-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <CAHQjnOOGWVcc95F==1__SCH0S-mX8bvRwOr7MhB3Arw=83jZMw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 11, 2012 at 11:34 PM, Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
> Hi!
>
> These two patches fixes operation of the SYSMMU driver (v12 version [1])
> with the new power domain driver based on generic power domains and
> runtime pw, which has been merged to Linux kernel v3.4-rc1.
>
Thanks, Marek.

Your way of power gating is right
and I will look into the changed runtime PM scheme in Exynos tree.

> [1] https://lkml.org/lkml/2012/3/15/51

Regards,

KyongHo
