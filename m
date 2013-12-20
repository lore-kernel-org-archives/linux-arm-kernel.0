From: marvin24@gmx.de (Marc Dietrich)
Date: Fri, 20 Dec 2013 11:16:23 +0100
Subject: [PATCH 00/10] ARM: tegra: DSI and panel support
In-Reply-To: <52B35346.1070202@wwwdotorg.org>
References: <1387468774-14216-1-git-send-email-treding@nvidia.com>
 <52B35346.1070202@wwwdotorg.org>
Message-ID: <1462944.fRZN5UYlz3@fb07-iapwap2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Am Donnerstag, 19. Dezember 2013, 13:12:54 schrieb Stephen Warren:
> On 12/19/2013 08:59 AM, Thierry Reding wrote:
> > This series of patches add support for Tegra114 display, DSI, HDMI, gr2d
> > and gr3d. Both DSI and HDMI outputs are enabled on Dalmore.
> > 
> > The LVDS panels on Harmony and Cardhu are added to the corresponding DTS
> > files and support for panels is enabled in the Tegra defconfig.
> 
> Very nice, and it all works and applies without conflicts:-) :-) :-)
> 
> Now I must run off and do the panels for Seaboard, Ventana, and the
> AC100 sometime.

no need for AC100, I'll submit a patch for it soon. They are already in one of 
my testing branches [1].

Thanks

Marc

[1] https://gitorious.org/ac100/marvin24s-kernel/commits/eab9a9a58b23d317c8cef9ba9b0a6ff2d7e25136
