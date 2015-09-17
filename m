From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 17 Sep 2015 22:52:10 +0200
Subject: [PATCH 4/4] i2c: stu300: Fix module autoload for OF platform
 driver
In-Reply-To: <20150917163647.GA26265@goodgumbo.baconseed.org>
References: <20150917163647.GA26265@goodgumbo.baconseed.org>
Message-ID: <CACRpkdb6NxPq07L_L9g_7mOX9c9LREM4o9nPUdbXTDid6S0PNA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 17, 2015 at 6:36 PM, Luis de Bethencourt
<luis@debethencourt.com> wrote:

> This platform driver has a OF device ID table but the OF module
> alias information is not created so module autoloading won't work.
>
> Signed-off-by: Luis de Bethencourt <luisbg@osg.samsung.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
