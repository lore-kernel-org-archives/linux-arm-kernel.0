From: naobsd@gmail.com (Naoki FUKAUMI)
Date: Wed, 11 Nov 2015 14:06:57 +0900
Subject: [PATCH] Revert "drm/rockchip: Convert the probe function to the
 generic drm_of_component_probe()"
In-Reply-To: <1447145239-10546-1-git-send-email-mark.yao@rock-chips.com>
References: <1447145239-10546-1-git-send-email-mark.yao@rock-chips.com>
Message-ID: <CAFnsNoTBUfWKq3Ou6MZ0T83gYgMRnT=okeNyj-NN49d6aC--MA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi,

On Tue, Nov 10, 2015 at 5:47 PM, Mark Yao <mark.yao@rock-chips.com> wrote:
> This reverts commit 52f5eb60940de889ce98a876f6933b574ead3225.
>
> Rockchip drm can't work with generic drm_of_component_probe now
>
> Signed-off-by: Mark Yao <mark.yao@rock-chips.com>

it makes rockchip-drm probed properly on linux-next-20151111 with
 multi_v7_defconfig
 +CONFIG_ROCKCHIP_PM_DOMAINS=y
 +https://patchwork.kernel.org/patch/7568821/

thank you very much.

Tested-by: FUKAUMI Naoki <naobsd@gmail.com>
