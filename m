From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 7 Jul 2014 17:36:41 +0200
Subject: [PATCH] pinctrl: pinctrl-at91.c: Cleaning up if unsigned is less
 than zero
In-Reply-To: <1403782005-9853-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
References: <1403782005-9853-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Message-ID: <CACRpkdZBCo9pw4sOiUaFQ2sJG5egEZ_VLekdCZ-PkyaTdL87gw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 26, 2014 at 1:26 PM, Rickard Strandqvist
<rickard_strandqvist@spectrumdigital.se> wrote:

> Remove checking if a unsigned is less than zero
>
> This was found using a static code analysis program called cppcheck.
>
> Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>

Patch applied. Thanks!

Yours,
Linus Walleij
