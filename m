From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 15 Apr 2013 12:43:40 +0200
Subject: [PATCH] ARM: ux500: Fix intcore regulator name
In-Reply-To: <1365499016-8348-1-git-send-email-fabio.baltieri@linaro.org>
References: <1365499016-8348-1-git-send-email-fabio.baltieri@linaro.org>
Message-ID: <CACRpkdb2NMdArJcp2niS4=-sbnZtj75itu5Rm5WA0BHMpO7amg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 9, 2013 at 11:16 AM, Fabio Baltieri
<fabio.baltieri@linaro.org> wrote:

> Ux500 regulator name for V-INTCORE is misspelled as vinitcore instead of
> vintcore in some .dts file, causing the AB8500 regulator driver to not
> bind properly.  Fix this by replacing all occurrences with the right
> name.
>
> Acked-by: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Fabio Baltieri <fabio.baltieri@linaro.org>

I've accumulated the patch in my tree but will not be sending to
ARM SoC for v3.10 as of now. Currently I have a huge conflict
between some 4-5 DT patches and ARM SoC and I will just wait
for -rc1 to happen before trying to clean out the mess.

Yours,
Linus Walleij
