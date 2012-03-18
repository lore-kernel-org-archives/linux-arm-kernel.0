From: olof@lixom.net (Olof Johansson)
Date: Sun, 18 Mar 2012 10:27:10 -0700
Subject: [PATCH] arm/tegra: pcie: fix return value of function
In-Reply-To: <4F5FA1BB.5050002@wwwdotorg.org>
References: <CAOesGMi0aqCjLsJ5wWXwFVQL2T8wtUuE14rFZ9h7NKHXcWAoqQ@mail.gmail.com>
 <1331617587-10714-1-git-send-email-mad_soft@inbox.ru>
 <4F5FA1BB.5050002@wwwdotorg.org>
Message-ID: <20120318172710.GA24110@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 13, 2012 at 01:36:27PM -0600, Stephen Warren wrote:
> On 03/12/2012 11:46 PM, Dmitry Artamonow wrote:
> > In previous patch (arm/tegra: add timeout to PCIe PLL lock detection loop)
> > tegra_pcie_enable_controller() function type has been changed from
> > void to int, but the last return statement wasn't converted, so
> > function returns undefined value. Fix it.
> > 
> > Also while at it, address couple of minor concerns raised by reviewers:
> > use usleep_range for delay, and lower the value of timeout to 300ms
> > to be consistent with Nvidia Vibrante kernel.
> > 
> > Signed-off-by: Dmitry Artamonow <mad_soft@inbox.ru>
> 
> Acked-by: Stephen Warren <swarren@wwwdotorg.org>

Thanks, applied to for-3.4/cleanups-and-fixes


-Olof
