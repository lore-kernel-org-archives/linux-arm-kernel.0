From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 11 May 2016 12:56:03 +0200
Subject: [PATCH v2 3/4] ARM64: Kconfig: Select the Amlogic Meson pin
 controller driver
In-Reply-To: <CACRpkdbTr7YUrzSQQci929ugBhTkJKWvpjdf5Wo3HkfVKFhGLw@mail.gmail.com>
References: <1462176138-29433-1-git-send-email-carlo@caione.org>
 <1462176138-29433-4-git-send-email-carlo@caione.org>
 <CACRpkdbTr7YUrzSQQci929ugBhTkJKWvpjdf5Wo3HkfVKFhGLw@mail.gmail.com>
Message-ID: <3200982.vJgYKNLqaA@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 11 May 2016 10:53:35 Linus Walleij wrote:
> On Mon, May 2, 2016 at 10:02 AM, Carlo Caione <carlo@caione.org> wrote:
> 
> > From: Carlo Caione <carlo@endlessm.com>
> >
> > Select the Meson pin controller driver also for the AArch64 Meson
> > platform.
> >
> > Signed-off-by: Carlo Caione <carlo@endlessm.com>
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 
> I guess this should get merged through the ARM SoC tree.
> 

I'd keep it together with the other changes for clarity and
merge it through your tree.

Acked-by: Arnd Bergmann <arnd@arndb.de>
