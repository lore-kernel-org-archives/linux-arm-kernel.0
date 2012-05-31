From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 31 May 2012 09:27:55 +0800
Subject: [RFC 34/34] dmaengine: PL08x: ensure all descriptors are freed
 when channel is released
In-Reply-To: <E1SZJ0j-000717-M3@rmk-PC.arm.linux.org.uk>
References: <20120529093015.GF12217@n2100.arm.linux.org.uk>
 <E1SZJ0j-000717-M3@rmk-PC.arm.linux.org.uk>
Message-ID: <CACRpkdawZm2J_4ujUv96-d0kDV0m7XOrr+wk8Wr92a3KLZcf2w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 29, 2012 at 5:46 PM, Russell King
<rmk+kernel@arm.linux.org.uk> wrote:

> Ensure all queued descriptors are freed when the channel is released,
> ensuring we don't leak memory
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Excellent series Russell, looking forward to a version that
applies on top of v3.5-rc:s and I'll test it. Would be great to get
this into the -next tree as soon as you think it's ripe.

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
