From: dongas86@gmail.com (Dong Aisheng)
Date: Thu, 9 Feb 2012 17:30:41 -0800
Subject: [PATCH] pinctrl: changes hog mechanism to be self-referential
In-Reply-To: <1328834868-25030-1-git-send-email-linus.walleij@linaro.org>
References: <1328834868-25030-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20120210013041.GA4436@b29396-Latitude-E6410>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 10, 2012 at 01:47:48AM +0100, Linus Walleij wrote:
> Instead of a specific boolean field to indicate if a map entry shall
> be hogged, treat self-reference as an indication of desired hogging.
> This drops one field off the map struct and has a nice Douglas R.
> Hofstadter-feel to it.
> 
> Suggested-by: Stephen Warren <swarren@nvidia.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  Documentation/pinctrl.txt       |    8 ++++----
>  drivers/pinctrl/core.c          |    6 ++----
>  include/linux/pinctrl/machine.h |   18 ++++++------------
>  3 files changed, 12 insertions(+), 20 deletions(-)
> 

A good cleanup.
Make the next pinctrl core dt binding a little easy for hog things.
Greatly hope this in.

Acked-by: Dong Aisheng <dong.aisheng@linaro.org>

Regards
Dong Aisheng
