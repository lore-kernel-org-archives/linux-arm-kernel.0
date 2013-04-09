From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 9 Apr 2013 09:43:07 +0200
Subject: [PATCH 4/6] pinctrl: samsung: Remove hardcoded register offsets
In-Reply-To: <1363642315-10331-5-git-send-email-tomasz.figa@gmail.com>
References: <1363642315-10331-1-git-send-email-tomasz.figa@gmail.com>
 <1363642315-10331-5-git-send-email-tomasz.figa@gmail.com>
Message-ID: <CACRpkdaAjhkg_Q+q9Jg+f9F_abbeYKs-sZcuTEZiDjd+rqCtpA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 18, 2013 at 10:31 PM, Tomasz Figa <tomasz.figa@gmail.com> wrote:

> This patch replaces statically hardcoded register offsets of Exynos SoCs
> with an array of register offsets in samsung_pin_bank_type struct.
>
> Thanks to this change, support for SoCs with other set and order of
> registers can be added (e.g. S3C24xx and S3C64xx).
>
> Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>

Patch applied.

Yours,
Linus Walleij
