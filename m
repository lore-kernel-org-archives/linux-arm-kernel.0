From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Fri, 23 Aug 2013 00:59:16 +0200
Subject: [PATCH] ARM: dts: exynos5420/5250: add ADC device tree node
In-Reply-To: <1377166691-5118-1-git-send-email-ch.naveen@samsung.com>
References: <1375349321-18646-1-git-send-email-ch.naveen@samsung.com>
 <1377166691-5118-1-git-send-email-ch.naveen@samsung.com>
Message-ID: <3452152.3bF3FnkbLl@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Naveen,

On Thursday 22 of August 2013 15:48:11 Naveen Krishna Chatradhi wrote:
> Add ADC device tree node for exynos5420 and exynos5250
> 
> Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
> Signed-off-by: Doug Anderson <dianders@chromium.org>
> ---
>  arch/arm/boot/dts/exynos5250.dtsi |   11 +++++++++++
>  arch/arm/boot/dts/exynos5420.dtsi |   11 +++++++++++
>  2 files changed, 22 insertions(+)

This patch looks good to me, but please resend it with all the recipients 
present in MAINTAINERS file for the directories from which files it 
changes, especially the devicetree at vger.kernel.org mailing list.

Best regards,
Tomasz
