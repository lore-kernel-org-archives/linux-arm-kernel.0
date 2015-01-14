From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 14 Jan 2015 12:41:45 +0100
Subject: [PATCH] mfd: db8500-prcmu: Remove unused function
In-Reply-To: <1420134593-690-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
References: <1420134593-690-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Message-ID: <CACRpkdY2namg-b1Qb0yHyR_043H4cVaUEPMhkG4kb=SJhrAjBg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 1, 2015 at 6:49 PM, Rickard Strandqvist
<rickard_strandqvist@spectrumdigital.se> wrote:

> Remove the function prcmu_get_boot_status() that is not used anywhere.
>
> This was partially found by using a static code analysis program called cppcheck.
>
> Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
