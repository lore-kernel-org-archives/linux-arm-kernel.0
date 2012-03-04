From: olof@lixom.net (Olof Johansson)
Date: Sun, 4 Mar 2012 10:37:32 -0800
Subject: [PATCH v2 3/6] ARM: tegra: build localtimer support only when
 needed
In-Reply-To: <1330721912-8694-1-git-send-email-alan@signal11.us>
References: <1330721912-8694-1-git-send-email-alan@signal11.us>
Message-ID: <20120304183732.GC31064@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 02, 2012 at 03:58:32PM -0500, Alan Ott wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> It is possible to build a tegra kernel without localtimer
> support, so the tegra specific parts should only be built
> when that is indeed enabled.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Alan Ott <alan@signal11.us>

Thanks, applied.

-Olof
