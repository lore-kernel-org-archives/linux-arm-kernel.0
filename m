From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 9 Sep 2016 20:36:13 +0800
Subject: [PATCH v3 2/4] ARM: sun5i: a13-olinuxino: Enable VGA bridge
In-Reply-To: <20160908121751.16911-3-maxime.ripard@free-electrons.com>
References: <20160908121751.16911-1-maxime.ripard@free-electrons.com>
 <20160908121751.16911-3-maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v66C1U8KqSec1Zk8Kyz2n5tQ-Ts4wADfOQR0njbrgnjOzw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 8, 2016 at 8:17 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Now that we have support for the VGA bridges using our DRM driver, enable
> the display engine for the Olimex A13-Olinuxino.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Assuming the bridge bindings are good,

Acked-by: Chen-Yu Tsai <wens@csie.org>
