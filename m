From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 8 Mar 2013 08:12:00 +0100
Subject: [PATCH v8 0/12] Palmas Updates
In-Reply-To: <513894E3.1070206@slimlogic.co.uk>
References: <1362662276-20792-1-git-send-email-ian@slimlogic.co.uk>
 <513894E3.1070206@slimlogic.co.uk>
Message-ID: <CACRpkdYHhh=ANiHvgxXiAQ_4LLiBBe0AfJ-60Wy6aEi7Cv0HOg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 7, 2013 at 2:23 PM, Ian Lartey <ian@slimlogic.co.uk> wrote:

> This patchset adds to the support for the Palmas iseries of PMIC chips.
>
> Some of the patches have previously been submitted individually.
> The DT bindings doc has been added first due to comments that it was
> missing.

Can the patches to the individual subsystems be applied individually
(like can we apply the two GPIO patches to the GPIO tree) or are
the deps such that the whole shebang needs to go in at once and you're
just harvesting ACKs to take it all into MFD or similar?

Yours,
Linus Walleij
