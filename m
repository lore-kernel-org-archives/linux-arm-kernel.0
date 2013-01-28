From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 28 Jan 2013 14:47:59 +0000
Subject: [v3 2/2] ARM: tegra: Skip scu_enable(scu_base) if not Cortex A9
In-Reply-To: <20130128091855.9e89d6da79bf5a264449ea5e@nvidia.com>
References: <1358833924-24535-1-git-send-email-hdoyu@nvidia.com>
 <1358833924-24535-2-git-send-email-hdoyu@nvidia.com> <50FE2CA8.20100@ti.com>
 <50FEC503.2080602@wwwdotorg.org>
 <CAOesGMgtaCkiv285TU_vbAokN5M2MrANQ9piDcyXu5YMmbQq3A@mail.gmail.com>
 <20130128091855.9e89d6da79bf5a264449ea5e@nvidia.com>
Message-ID: <20130128144759.GK23505@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 28, 2013 at 09:18:55AM +0200, Hiroshi Doyu wrote:
> Hi Russell,
> 
> On Tue, 22 Jan 2013 18:04:46 +0100
> Olof Johansson <olof@lixom.net> wrote:
> 
> > Since Russell had comments on it earlier, I'd like him to give a nod
> > that he's happy with it too.
> 
> Is this ok for you?
> 
> The original patch is:
> http://lists.infradead.org/pipermail/linux-arm-kernel/2013-January/143552.html

Yes, this version is much better, thanks.

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>
