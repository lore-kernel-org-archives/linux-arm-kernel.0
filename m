From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 16 Sep 2013 09:28:22 -0600
Subject: [PATCH] crypto: tegra: use kernel entropy instead of ad-hoc
In-Reply-To: <20130913233912.GA16389@gondor.apana.org.au>
References: <1378712154-30602-1-git-send-email-linus.walleij@linaro.org>
 <522DF0FC.5080200@wwwdotorg.org> <20130913122318.GD8579@gondor.apana.org.au>
 <52333974.4040404@wwwdotorg.org> <20130913233912.GA16389@gondor.apana.org.au>
Message-ID: <52372396.8030707@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/13/2013 05:39 PM, Herbert Xu wrote:
> On Fri, Sep 13, 2013 at 10:12:36AM -0600, Stephen Warren wrote:
>>
>> I'm curious which kernel version it was merged for; it'd be nice to
>> remove tegra_chip_uid() from the Tegra tree now since it's unused, but
>> that obviously requires this patch in the history.
> 
> This is in cryptodev which will be pushed upstream for 3.13.

OK, I guess I'll send you the follow-on cleanup patch then. While it
does touch arch/arm/mach-tegra code, I hope it won't conflict with
anything else going through the Tegra tree, so should be safe.
