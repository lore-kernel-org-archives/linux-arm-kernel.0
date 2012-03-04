From: olof@lixom.net (Olof Johansson)
Date: Sun, 4 Mar 2012 10:38:23 -0800
Subject: [PATCH v2 6/6] ARM: tegra: export usb phy symbols
In-Reply-To: <1330721922-8861-1-git-send-email-alan@signal11.us>
References: <1330721922-8861-1-git-send-email-alan@signal11.us>
Message-ID: <20120304183823.GD31064@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 02, 2012 at 03:58:42PM -0500, Alan Ott wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The ehci driver can be a module, so the functions provided
> by the tegra platform code used by ehci-tegra need to
> be exported.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Alan Ott <alan@signal11.us>

Thanks, applied.


-Olof
