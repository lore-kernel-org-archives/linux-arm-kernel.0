From: t.figa@samsung.com (Tomasz Figa)
Date: Wed, 28 Aug 2013 14:58:41 +0200
Subject: [Patch v2] pinctrl: Add s5pv210 support to pinctrl-exynos
In-Reply-To: <CACRpkdYiB5OG-YPRozwEurPHECDzZjQUs2s_E8gCdeqDPyr+WA@mail.gmail.com>
References: <1377608890-8528-1-git-send-email-m.krawczuk@partner.samsung.com>
 <CACRpkdYiB5OG-YPRozwEurPHECDzZjQUs2s_E8gCdeqDPyr+WA@mail.gmail.com>
Message-ID: <3439226.L4MiyJHvQr@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 28 of August 2013 14:51:44 Linus Walleij wrote:
> On Tue, Aug 27, 2013 at 3:08 PM, Mateusz Krawczuk
> 
> <m.krawczuk@partner.samsung.com> wrote:
> > This patch implements pinctrl support and adds device tree bindings
> > for s5pv210.
> > 
> > Signed-off-by: Mateusz Krawczuk <m.krawczuk@partner.samsung.com>
> 
> Oh this one does add bindings, sorry for previous comment.
> 
> I want an ACK from Kukjin or Sylwester for this since it's
> something new for S5P.

Well, it does not touch anything outside drivers/pinctrl/, so my and your 
ACKs should be enough, but since this patch is just one day old, let's give 
it a bit more time for people to review it, if you don't have to hurry with 
it yet.

Best regards,
Tomasz
