From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Mon, 28 Jan 2013 09:18:55 +0200
Subject: [v3 2/2] ARM: tegra: Skip scu_enable(scu_base) if not Cortex A9
In-Reply-To: <CAOesGMgtaCkiv285TU_vbAokN5M2MrANQ9piDcyXu5YMmbQq3A@mail.gmail.com>
References: <1358833924-24535-1-git-send-email-hdoyu@nvidia.com>
 <1358833924-24535-2-git-send-email-hdoyu@nvidia.com>
 <50FE2CA8.20100@ti.com> <50FEC503.2080602@wwwdotorg.org>
 <CAOesGMgtaCkiv285TU_vbAokN5M2MrANQ9piDcyXu5YMmbQq3A@mail.gmail.com>
Message-ID: <20130128091855.9e89d6da79bf5a264449ea5e@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Tue, 22 Jan 2013 18:04:46 +0100
Olof Johansson <olof@lixom.net> wrote:

> Since Russell had comments on it earlier, I'd like him to give a nod
> that he's happy with it too.

Is this ok for you?

The original patch is:
http://lists.infradead.org/pipermail/linux-arm-kernel/2013-January/143552.html
