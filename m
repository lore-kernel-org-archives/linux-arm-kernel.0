From: dianders@chromium.org (Doug Anderson)
Date: Fri, 18 Mar 2016 15:53:14 -0700
Subject: [PATCH v14 0/17] Add Analogix Core Display Port Driver
In-Reply-To: <56EBA305.8030202@gmail.com>
References: <1455534485-1154-1-git-send-email-ykk@rock-chips.com>
 <56EBA305.8030202@gmail.com>
Message-ID: <CAD=FV=XXESzA6n6MNEGH1Kbh7CeL8xWX8CifFLVf91+0JyFcJQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Mar 17, 2016 at 11:41 PM, Caesar Wang <caesar.upstream@gmail.com> wrote:
> Hi all,
>
> I pick this series up and test on C101PA chromebook, after Heiko update the
> 3 patches.
>
> [v14.1,09/17] drm: rockchip: dp: add rockchip platform dp driver
> [v14.1,04/17] drm: bridge: analogix/dp: fix some obvious code style
> [v14.1,01/17] drm: bridge: analogix/dp: split exynos dp driver to bridge
> directory
>
> C101PA chromebook:
> http://www.amazon.co.uk/10-1-Inch-Chromebook-Rockchip-Integrated-Graphics/dp/B0107N7WT6/ref=lp_758129031_1_4?s=computers&ie=UTF8&qid=1458282912&sr=1-4
>
> So, verified for the rockchip eDp contrller on my github.
> https://github.com/Caesar-github/rockchip/tree/veyron/next-stable-chromeos

I did similar to Caesar but I tested on veyron-jerry instead of
veyron-mickey.  Like Caesar, I picked these together Heiko's v14.1
patches to resolve merge conflicts.  I also picked into a slightly
different tree (mine was a 4.4-based tree with backports, including
Heiko's latest eDP device tree patches).

Tough I haven't reviewed the code and am not a graphics expert, I'd
very much love to see this landed, presumably right after the merge
window closes.  Yakir's first patch
<https://patchwork.kernel.org/patch/6959211/> is nearly 1 year old and
it really seems like if there were any major objections left they'd
have been stated by now.  v14 appears to be about 1 month old with no
major comments.

Tested-by: Douglas Anderson <dianders@chromium.org>


-Doug
