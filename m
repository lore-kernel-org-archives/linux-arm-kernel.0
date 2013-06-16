From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 16 Jun 2013 14:43:30 +0200
Subject: [PATCH 2/7] gpio: clean up gpio-ranges documentation
In-Reply-To: <1371157199-7272-2-git-send-email-swarren@wwwdotorg.org>
References: <1371157199-7272-1-git-send-email-swarren@wwwdotorg.org>
 <1371157199-7272-2-git-send-email-swarren@wwwdotorg.org>
Message-ID: <CACRpkdYhMGg3OXTuD9T3WS3SQT2P+1WGG5KexmNqzomd00nErQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 13, 2013 at 10:59 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:

> From: Stephen Warren <swarren@nvidia.com>
>
> This change makes documentation of the the gpio-ranges property shorter
> and more succinct, more consistent with the style of the rest of the
> document, and not mention Linux-specifics such as the API
> pinctrl_request_gpio(); DT binding documents should be OS independant
> where at all possible.
>
> This change also removes any mention of the #gpio-range-cells property.
> Such properties are useful when one node references a second node, and
> that second node dictates the format of the reference. However, that is
> not the case here; the definition of gpio-ranges itself always dictates
> its format entirely, and hence the value #gpio-range-cells must always
> be 3, and hence there is no point requiring any referenced node to
> include this property.
>
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
> Patches 2-6 need to be applied in the same branch, since they all build
> upon each-other.

Very nice. If I can just get the OF maintainers to ACK the OF
patches I can carry this stuff in pinctrl or gpio alike.

Yours,
Linus Walleij
