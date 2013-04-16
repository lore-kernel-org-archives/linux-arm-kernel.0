From: grant.likely@secretlab.ca (Grant Likely)
Date: Tue, 16 Apr 2013 11:24:02 +0100
Subject: [REPOST PATCH] spi: s3c64xx: let device core setup the default
 pin configuration
In-Reply-To: <1366083777-9118-1-git-send-email-dianders@chromium.org>
References: <1362570130-14084-1-git-send-email-thomas.abraham@linaro.org>
 <1366083777-9118-1-git-send-email-dianders@chromium.org>
Message-ID: <20130416102402.DF3493E14C0@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 15 Apr 2013 20:42:57 -0700, Doug Anderson <dianders@chromium.org> wrote:
> From: Thomas Abraham <thomas.abraham@linaro.org>
> 
> With device core now able to setup the default pin configuration,
> the pin configuration code based on the deprecated Samsung specific
> gpio bindings is removed.
> 
> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
> Signed-off-by: Doug Anderson <dianders@chromium.org>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Reviewed-by: Doug Anderson <dianders@chromium.org>
> Tested-by: Doug Anderson <dianders@chromium.org>

Applied, thanks.

g.
