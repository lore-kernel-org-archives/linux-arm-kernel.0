From: dianders@chromium.org (Doug Anderson)
Date: Thu, 11 Sep 2014 10:41:02 -0700
Subject: [PATCH 1/2] ARM: rockchip: add basic smp support for rk3288
In-Reply-To: <1410343554-8383-2-git-send-email-kever.yang@rock-chips.com>
References: <1410343554-8383-1-git-send-email-kever.yang@rock-chips.com>
 <1410343554-8383-2-git-send-email-kever.yang@rock-chips.com>
Message-ID: <CAD=FV=UafRXZ=qHbTdsg88ZwWO-1qPA7ERvCN8321GcjybYUiA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kever,

On Wed, Sep 10, 2014 at 3:05 AM, Kever Yang <kever.yang@rock-chips.com> wrote:
> -CPU_METHOD_OF_DECLARE(rk3066_smp, "rockchip,rk3066-smp", &rockchip_smp_ops);
> +CPU_METHOD_OF_DECLARE(rk3288_smp, "rockchip,rk3288-smp", &rockchip3288_smp_ops);

I haven't done a full review, but I think that the above means you
need to update "Documentation/devicetree/bindings/arm/cpus.txt".

-Doug
