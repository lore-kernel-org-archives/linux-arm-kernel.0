From: olof@lixom.net (Olof Johansson)
Date: Mon, 14 Jan 2013 22:27:16 -0800
Subject: [PATCH v4 2/5] ARM: dts: Add disable-wp for sd card slot on
 smdk5250
In-Reply-To: <1357923834-31641-2-git-send-email-dianders@chromium.org>
References: <1357842269-15062-1-git-send-email-dianders@chromium.org>
 <1357923834-31641-1-git-send-email-dianders@chromium.org>
 <1357923834-31641-2-git-send-email-dianders@chromium.org>
Message-ID: <20130115062716.GB20105@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 11, 2013 at 09:03:51AM -0800, Doug Anderson wrote:
> The next change will remove the code from the dw_mmc-exynos that added
> the DW_MCI_QUIRK_NO_WRITE_PROTECT.  Keep existing functionality of
> having no write protect pin on smdk5250 by adding the disable-wp
> property.
> 
> Signed-off-by: Doug Anderson <dianders@chromium.org>
> Acked-by: Seungwon Jeon <tgih.jun@samsung.com>

Acked-by: Olof Johansson <olof@lixom.net>


-Olof
