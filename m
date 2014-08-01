From: dianders@chromium.org (Doug Anderson)
Date: Fri, 1 Aug 2014 13:37:13 -0700
Subject: [PATCH v5 06/10] ARM: dts: Clean up exynos5250-smdk5250
In-Reply-To: <1406868897-26874-7-git-send-email-afaerber@suse.de>
References: <1406868897-26874-1-git-send-email-afaerber@suse.de>
 <1406868897-26874-7-git-send-email-afaerber@suse.de>
Message-ID: <CAD=FV=Vra6p3bUeHGz6hTXjM1QMCZ-Ph++oqMWFAj1Uqmdg1rw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andreas,

On Thu, Jul 31, 2014 at 9:54 PM, Andreas F?rber <afaerber@suse.de> wrote:
> Use the new style for referencing inherited nodes and use symbolic names.
>
> Goal is the alignment of all exynos5250 based device trees for comparison.
>
> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> ---
>  v5: New
>  Follow-up after adding dp_hpd pinctrl node new-style.

Since I NAKed that one, are you going to drop this patch?  It's
probably still a useful thing to do.

It sounds like you might be spinning?  ...if so I'll review it in the
next cycle...  Note: same feedback as before about splitting changes
to exynos5250.dtsi and actual board files...

-Doug
