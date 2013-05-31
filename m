From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 31 May 2013 14:45:13 +0200
Subject: [PATCH 21/39] ARM: u300: delete all static board data
In-Reply-To: <6751591.S13Ph9lFnY@wuerfel>
References: <1369991954-17406-1-git-send-email-linus.walleij@stericsson.com>
 <1369991954-17406-22-git-send-email-linus.walleij@stericsson.com>
 <6751591.S13Ph9lFnY@wuerfel>
Message-ID: <CACRpkdbi-xPFiy=N4=5V7cOkRPYJcoj4beTkaDLoODxxko17tw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 31, 2013 at 12:49 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> I did not see any patch removing the auxdata list in the end.
> Do you still need it after the clocks are moved over to DT
> probing?

Unfortunately yes.

I am still using the device names to resolve pin control
handles.

It's on the TODO. Once that is done this can be deleted.

Yours,
Linus Walleij
