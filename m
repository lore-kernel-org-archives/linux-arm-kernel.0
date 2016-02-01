From: dianders@chromium.org (Doug Anderson)
Date: Mon, 1 Feb 2016 09:19:50 -0800
Subject: [PATCH] ARM: dts: cros-ec-keyboard: Add LOCK key to keyboard
 matrix
In-Reply-To: <1454121504-12683-1-git-send-email-djkurtz@chromium.org>
References: <1454121504-12683-1-git-send-email-djkurtz@chromium.org>
Message-ID: <CAD=FV=WB274i3r+aYVG4kOtwPzWgmx2E-MfjPcdKfcd7pXUSPA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dan,

On Fri, Jan 29, 2016 at 6:38 PM, Daniel Kurtz <djkurtz@chromium.org> wrote:
> From: James Chao <james_chao@asus.com>
>
> The LOCK key is at KSO9/KSI3 for Chromebook Flip and other devices
> that use the Chrome OS EC keyboard matrix.
>
> Signed-off-by: James Chao <james_chao@asus.com>
> Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
> Signed-off-by: YH Huang <yh.huang@mediatek.com>
> ---
>  arch/arm/boot/dts/cros-ec-keyboard.dtsi | 1 +
>  1 file changed, 1 insertion(+)

Feel free to add:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
