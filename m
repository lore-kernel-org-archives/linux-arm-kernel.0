From: cjb@laptop.org (Chris Ball)
Date: Thu, 27 Jun 2013 10:32:08 -0400
Subject: [PATCH v2] mmc: sdhci-sirf: let device core setup the default pin
 configuration
In-Reply-To: <1368522511-26491-1-git-send-email-Baohua.Song@csr.com> (Barry
 Song's message of "Tue, 14 May 2013 17:08:31 +0800")
References: <1368522511-26491-1-git-send-email-Baohua.Song@csr.com>
Message-ID: <87obarsjyv.fsf@octavius.laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, May 14 2013, Barry Song wrote:
> With device core now able to setup the default pin configuration, the call
> to devm_pinctrl_get_select_default can be removed. And the pin configuration
> code based on the deprecated Samsung specific gpio bindings is also removed.
>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>

Thanks, pushed to mmc-next for 3.11.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
