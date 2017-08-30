From: olof@lixom.net (Olof Johansson)
Date: Tue, 29 Aug 2017 22:24:48 -0700
Subject: [PATCH] arm64: defconfig: enable rockchip graphics
In-Reply-To: <599F863D.5020208@rock-chips.com>
References: <20170824150210.10949-1-heiko@sntech.de>
 <599F863D.5020208@rock-chips.com>
Message-ID: <20170830052448.GF14499@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 25, 2017 at 10:06:53AM +0800, Mark yao wrote:
> On 2017???08???24??? 23:02, Heiko Stuebner wrote:
> >Enable the graphics-related options needed by Rockchip boards.
> >This includes the pwm-backlight which will be needed by the internal
> >displays used on Gru Chrome-devices.
> >
> >Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> >---
> Hi Heiko
> 
> Thanks for the patch, and it looks good for me.
> 
> Reviewed-by: Mark Yao at rock-chips.com

THat's not the right format for tags, but applied with it fixed up.


-Olof
