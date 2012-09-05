From: olof@lixom.net (Olof Johansson)
Date: Tue, 4 Sep 2012 21:38:36 -0700
Subject: [PATCH] ARM: ux500: Correct Ux500 family names usage
In-Reply-To: <1346677823-28158-1-git-send-email-linus.walleij@stericsson.com>
References: <1346677823-28158-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20120905043836.GC6747@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 03, 2012 at 03:10:23PM +0200, Linus Walleij wrote:
> From: Loic PALLARDY <loic.pallardy@st.com>
> 
> Update users with cpu_is_ux540_family() to keep x540
> family functional.
> 
> Signed-off-by: Loic Pallardy <loic.pallardy@stericsson.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Hi Arnd, Olof:
> 
> This patch goes on top of the ux500-asicid patches pulled earlier,
> into your ux500/asic-id branch, it'd be best if you just applied
> this one on top manually. If you prefer I can send a new pull
> request from the same branch.

Sure, applied.


-Olof
