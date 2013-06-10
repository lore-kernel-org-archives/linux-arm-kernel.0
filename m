From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 10 Jun 2013 16:35:56 +0200
Subject: [PATCH 00/10] regulator: ab8500-ext: Refactorings
In-Reply-To: <1370621488-18130-1-git-send-email-lee.jones@linaro.org>
References: <1370621488-18130-1-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdbygDNdsO=EzigPiBSnMmF-NVnF95HeBBavkry93i+ubQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 7, 2013 at 6:11 PM, Lee Jones <lee.jones@linaro.org> wrote:

> This patch aims to do the following:
>
>  - Separate the AB8500 External Regulator out from the AB8500 core
>    one for added control and reduced complexity
>  - Enable the AB8500 External Regulator for Device Tree
>  - Ensure EXT3 supplies the AUX regulators with voltage

The series:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Once the changes to MFD+Regulator are in I'm happy to take the
DT patches onto my ux500-devicetree branch. However I fear
I'll break something if I do it right now?

Yours,
Linus Walleij
