From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 7 Jul 2014 17:54:50 +0200
Subject: [PATCH] pinctrl: pinctrl-st.c: Cleaning up values that are never
 used
In-Reply-To: <1403790272-11635-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
References: <1403790272-11635-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Message-ID: <CACRpkdYZgv6-bffreCvcXjBHGW09+i2dvtd7P-r77RJ8JPU9kQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 26, 2014 at 3:44 PM, Rickard Strandqvist
<rickard_strandqvist@spectrumdigital.se> wrote:

> Remove variable that are never used
>
> This was found using a static code analysis program called cppcheck.
>
> Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>

Patch applied with Patrice's ACK.

Yours,
Linus Walleij
