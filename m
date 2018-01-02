From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 2 Jan 2018 09:44:11 +0100
Subject: [PATCH] pinctrl: at91: Delete an error message for a failed
 memory allocation in at91_pinctrl_mux_mask()
In-Reply-To: <b5da388b-7fa2-ad77-7b64-26eadd55b41c@users.sourceforge.net>
References: <b5da388b-7fa2-ad77-7b64-26eadd55b41c@users.sourceforge.net>
Message-ID: <CACRpkdY2F0AZLJuRNYCMJp9gNAws0-0nVuOAv=3FaHfJRMEUrg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 23, 2017 at 8:55 PM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 23 Dec 2017 20:44:27 +0100
>
> Omit an extra message for a memory allocation failure in this function.
>
> This issue was detected by using the Coccinelle software.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Patch applied.

Yours,
Linus Walleij
