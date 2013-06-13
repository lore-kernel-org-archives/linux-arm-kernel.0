From: olof@lixom.net (Olof Johansson)
Date: Thu, 13 Jun 2013 12:58:01 -0700
Subject: [PATCH v4 0/7] support Hisilicon SoC
In-Reply-To: <201306131829.47348.heiko@sntech.de>
References: <1370702843-27172-1-git-send-email-haojian.zhuang@linaro.org>
 <20130612200142.GD5162@quad.lixom.net>
 <201306131829.47348.heiko@sntech.de>
Message-ID: <20130613195801.GA21765@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 13, 2013 at 06:29:47PM +0200, Heiko St?bner wrote:
> Am Mittwoch, 12. Juni 2013, 22:01:42 schrieb Olof Johansson:
> > On Sat, Jun 08, 2013 at 10:47:16PM +0800, Haojian Zhuang wrote:
> > > Changelog:
> > > v4:
> > > 1. Add clk gate with HIWORD mask for Rockchip.
> > > 2. Update comments and code of HIWORD flags for mux/divider.
> > > 3. Append a mux without HIWORD mask in Hisilicon 3620.
> > > 4. Fix the pinmux setting in Hi4511.
> > > 
> > > v3:
> > > 1. Use clk_register_mux_table().
> > > 
> > > v2:
> > > 1. Reuse mux & divider driver. So append CLK_MUX_HIWORD_MASK &
> > > CLK_DIVIDER_HIWORD_MASK for Hi3620 SoC.
> > > 2. Fix system timer running too fast because wrong divider is choosen.
> > > 3. Remove .init_irq in DT machine descriptor.
> > 
> > Hi,
> > 
> > I had some comments on the last two patches. I also haven't seen any acks
> > from Mike on any of the clock changes, which would be needed before we can
> > pick them up. He might want to merge them into his tree as well, if so
> > we'll have to setup a shared branch.
> 
> Also, if anything unexpected happens to the main hisilicon support, could you 
> or Mike pick up the HIWORD_MASK patches anyway (if they are acceptable), 
> because they're needed for the Rockchip stuff too.

Ok, that definitely means a topic branch would be a good idea. Mike, can you
collect these branches on a topic that we can just pull in as a dependency
then, please? Assuming you're happy with them, of course.

Thanks!

-Olof
