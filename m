From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 14 Jan 2015 12:53:07 +0100
Subject: [PATCH] arm: mach-versatile: core: Remove unused function
In-Reply-To: <1420303959-12898-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
References: <1420303959-12898-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Message-ID: <CACRpkdan1BZQnYgTdF9ctbLOPNoDwDX3Epy8Xfttd2v4-G-4Lw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 3, 2015 at 5:52 PM, Rickard Strandqvist
<rickard_strandqvist@spectrumdigital.se> wrote:

> Remove the function versatile_leds_event() that is not used anywhere.
>
> This was partially found by using a static code analysis program called cppcheck.
>
> Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

That's right, the code was made redundant in
commit e031cd513ec2ff661465dc1198220075719e72d1
"ARM: mach-realview and mach-versatile: retire custom LED code"

ARM SoC folks: I suggest you apply this patch directly to your cleanup
branch.

Yours,
Linus Walleij
