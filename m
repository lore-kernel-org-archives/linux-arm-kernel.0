From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 14 Jul 2012 23:49:47 +0200
Subject: [PATCH v2 05/15] ARM: integrator: use fixed PCI i/o mapping
In-Reply-To: <1342231451-28861-6-git-send-email-robherring2@gmail.com>
References: <1342231451-28861-1-git-send-email-robherring2@gmail.com>
 <1342231451-28861-6-git-send-email-robherring2@gmail.com>
Message-ID: <CACRpkda_to3CzfhvOh-NDx_7Qz+Reg6m1k+uH2stRFy8KSqQmQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 14, 2012 at 4:04 AM, Rob Herring <robherring2@gmail.com> wrote:

> From: Rob Herring <rob.herring@calxeda.com>
>
> Move integrator PCI to fixed i/o mapping and remove io.h.
>
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Linus Walleij <linus.walleij@linaro.org>

I think the PCI bus on my Integrator/AP is tilted and not suitable
for tests. But IIRC Will Deacon actually has one of these machines
and managed to get ethernet going on it. Maybe he can even test
this patch?

Yours,
Linus Walleij
