From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 3 Apr 2013 18:31:58 +0200
Subject: [PATCHv7 00/17] PCIe support for the Armada 370 and Armada XP SoCs
In-Reply-To: <20130403142712.160be55e@skate>
References: <1364395234-11195-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130403142712.160be55e@skate>
Message-ID: <CACRpkdYbxXqP_KdcfUFCU4ZyNLn3SmLYcio5QgPqE=zLP7FV2w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 3, 2013 at 2:27 PM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:

> Bjorn, Rob, Grant, Russell,
>
> Through this e-mail, I'd like to send you a kind reminder about this
> patch series. The latest version has been sent a week ago, and there
> has been only minor changes requested since v4 sent early March, i.e a
> month ago. Therefore, I would hope for this series to enter 3.10.
>
> But this patch set is touching areas you are the maintainer for, so I
> would appreciate if you could do a formal review and give your comments
> or your Ack. I would especially appreciate if you do so in the very
> near future, so that if there are comments, I'll have the time to fix
> them and resubmit and updated version in time.
>
> Here are the patches, classified by maintainer area:

FYI I have applied patches 1 thru 3 and converted my PCI DT series
for the Integrator to use the new infrastructure, so you can add
Tested-by: Linus Walleij <linus.walleij@linaro.org>
on these if you wish. (Working fine.)

The Integrator PCI DT work is dependent on these patches so I
also have a strong interest to have them merged somewhere so I
can submit my series against them...

Yours,
Linus Walleij
