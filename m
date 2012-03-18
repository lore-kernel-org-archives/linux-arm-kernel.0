From: olof@lixom.net (Olof Johansson)
Date: Sun, 18 Mar 2012 10:36:06 -0700
Subject: [PATCH v3 4/5] ARM: tegra: select USB_ULPI if USB is selected
In-Reply-To: <1330727160-11242-1-git-send-email-alan@signal11.us>
References: <1330727075-10974-1-git-send-email-alan@signal11.us>
 <1330727160-11242-1-git-send-email-alan@signal11.us>
Message-ID: <20120318173606.GA24327@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 02, 2012 at 05:26:00PM -0500, Alan Ott wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Automatically select USB_ULPI if USB is enabled on Tegra.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Alan Ott <alan@signal11.us>

Thanks, applied. I think this was the last outstanding patch that I had not yet
applied. Since there had been some slight confusion with v2 vs v3, please check
the contents of the tegra for-next branch and make sure it contains what you
would expect it to.

Thanks!


-Olof
