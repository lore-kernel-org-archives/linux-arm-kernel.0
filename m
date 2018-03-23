From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 23 Mar 2018 04:01:16 +0100
Subject: [PATCH v2] pinctrl: pinctrl-single: Fix pcs_request_gpio() when
 bits_per_mux != 0
In-Reply-To: <1519077427-30165-1-git-send-email-david@lechnology.com>
References: <1519077427-30165-1-git-send-email-david@lechnology.com>
Message-ID: <CACRpkdanFFwPBhkDNRTdns9cPebH3drBZNhqZLBzF78U3XdRgw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 19, 2018 at 10:57 PM, David Lechner <david@lechnology.com> wrote:

> This fixes pcs_request_gpio() in the pinctrl-single driver when
> bits_per_mux != 0. It appears this was overlooked when the multiple
> pins per register feature was added.
>
> Fixes: 4e7e8017a80e ("pinctrl: pinctrl-single: enhance to configure multiple pins of different modules")
> Signed-off-by: David Lechner <david@lechnology.com>
> ---
>
> v2 changes:
> - don't wrap Fixes: line in commit message since it is a special machine-
>   readable line.

Tony/Haojian: are you OK with this change?

Yours,
Linus Walleij
