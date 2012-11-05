From: olof@lixom.net (Olof Johansson)
Date: Mon, 5 Nov 2012 18:37:43 +0100
Subject: [PATCH V4 REPOST] ARM: implement debug_ll_io_init()
In-Reply-To: <1351718515-871-1-git-send-email-swarren@wwwdotorg.org>
References: <1351718515-871-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <CAOesGMh84DVzwHd8z+fcLeSmcDoSm566MOXQYi2u7uX6S1t5Bg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 31, 2012 at 10:21 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:

> Arnd, Olof, could this patch be placed into a standalone topic branch in
> arm-soc branch; I'd like to make use of this patch for both Tegra and
> bcm2835 this cycle, and perhaps others might too. Thanks.

Done, applied to single-patch branch devel/debug_ll_init. I'll bring
that in at next/multiplatform as well.


-Olof
