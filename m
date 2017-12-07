From: khilman@baylibre.com (Kevin Hilman)
Date: Thu, 07 Dec 2017 12:31:16 -0800
Subject: [PATCH] clk: meson: make the spinlock naming more specific
In-Reply-To: <20171204052739.10747-1-yixun.lan@amlogic.com> (Yixun Lan's
 message of "Mon, 4 Dec 2017 13:27:39 +0800")
References: <20171204052739.10747-1-yixun.lan@amlogic.com>
Message-ID: <7hpo7qp9ez.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Yixun Lan <yixun.lan@amlogic.com> writes:

> Make the spinlock more specific, so better for lockdep
> debugging and ctags/grep.
>
> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
>
> ---
>
> this patch try to address the issue which bring up by Stephen at [1]
> [1] http://lists.infradead.org/pipermail/linux-amlogic/2017-December/005534.html

FYI... for future reference, it's common to use a Suggested-by tag to
give credit for these kinds of things.  e.g.:

Suggested-by: Stephen Boyd <sboyd@codeaurora.org>

Kevin
