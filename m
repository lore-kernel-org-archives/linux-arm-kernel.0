From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 7 Feb 2012 06:10:26 +0100
Subject: [PATCH 3/3] ARM: remove empty disable_fiq and arch_ret_to_user
 macros
In-Reply-To: <1328562200-8810-4-git-send-email-robherring2@gmail.com>
References: <1328562200-8810-1-git-send-email-robherring2@gmail.com>
 <1328562200-8810-4-git-send-email-robherring2@gmail.com>
Message-ID: <CACRpkdZH-wakJmz0mrnn-RJyeqhrR7a3eGceq0P+9zXk0M_xvw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 6, 2012 at 10:03 PM, Rob Herring <robherring2@gmail.com> wrote:

> From: Rob Herring <rob.herring@calxeda.com>
>
> Now that most platforms don't need disable_fiq and arch_ret_to_user
> macros, we can remove the empty macros or empty entry-macro.S files.
>
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>

Good riddance!
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
