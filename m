From: dianders@chromium.org (Doug Anderson)
Date: Fri, 1 Aug 2014 09:26:48 -0700
Subject: [PATCH v5 01/10] ARM: dts: Fix MMC pinctrl for exynos5250-snow
In-Reply-To: <1406868897-26874-2-git-send-email-afaerber@suse.de>
References: <1406868897-26874-1-git-send-email-afaerber@suse.de>
 <1406868897-26874-2-git-send-email-afaerber@suse.de>
Message-ID: <CAD=FV=VBa5rs_woj0mshFFbA69Nhyi3hXK_XX7-54T3vFyKYHA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Jul 31, 2014 at 9:54 PM, Andreas F?rber <afaerber@suse.de> wrote:
> The pinctrl properties should be on the device directly and not on the
> slot sub-node.
>
> Reported-by: Doug Anderson <dianders@chromium.org>
> Cc: Jaehoon Chung <jh80.chung@samsung.com>
> Reviewed-by: Tomasz Figa <t.figa@samsung.com>
> Signed-off-by: Andreas F?rber <afaerber@suse.de>

Let's land this one before Jaehoon's, since it was a hidden
functionality change in his patch.  It will be an easy conflict to
resolve when his patch is applied.

Reviewed-by: Doug Anderson <dianders@chromium.org>
