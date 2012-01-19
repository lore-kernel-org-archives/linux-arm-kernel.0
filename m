From: nsekhar@ti.com (Nori, Sekhar)
Date: Thu, 19 Jan 2012 20:23:03 +0000
Subject: [PATCH] ARM: mach-davinci DA850: removed un-existing
 pll1_sysclk4-7 clock domains
In-Reply-To: <20120116064559.GA3025@altenpts-laptop>
References: <20120116064559.GA3025@altenpts-laptop>
Message-ID: <DF0F476B391FA8409C78302C7BA518B631796036@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bas van den,

On Mon, Jan 16, 2012 at 12:16:02, Bas van den Berg wrote:
> DA850: sysclk4-7 only exist for pll0. for pll1 sysclk1-3 exist.
> 
> Signed-off-by: Bas van den Berg <b.van.den.berg.nl@gmail.com>

Applied, thanks.

Please note that there is no need to add "mach-" in front of
davinci in subject line. It helps to keep the subject lines
consistent.

While committing, I changed the subject to:

"ARM: davinci: DA850: remove non-existing pll1_sysclk4-7 clocks"

Please take care next time on.

Thanks,
Sekhar
