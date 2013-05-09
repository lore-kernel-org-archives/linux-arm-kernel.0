From: olof@lixom.net (Olof Johansson)
Date: Thu, 9 May 2013 13:25:34 -0700
Subject: [PATCH] ARM: exynos: dts: Fixed vbus-gpios
In-Reply-To: <1368034636-15865-1-git-send-email-dianders@chromium.org>
References: <1368034636-15865-1-git-send-email-dianders@chromium.org>
Message-ID: <20130509202534.GB21831@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 08, 2013 at 10:37:16AM -0700, Doug Anderson wrote:
> The 'samsung,vbus-gpio' was submitted before pinmux landed for
> exynos5250 and uses the old-style gpio specifier.  Fix the two
> exynos5250 boards that use it.
> 
> Signed-off-by: Doug Anderson <dianders@chromium.org>


Applied to arm-soc fixes.

Thanks,


-Olof
