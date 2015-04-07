From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 7 Apr 2015 11:06:50 +0200
Subject: [PATCH] pinctrl: at91: convert __raw to endian agnostic IO
In-Reply-To: <1427372329-26005-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1427372329-26005-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <CACRpkdY26txvV92SePv02EdX6TOcTBn9uWPX08gC2oAi7XGs0A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 26, 2015 at 1:18 PM, Ben Dooks <ben.dooks@codethink.co.uk> wrote:

> Use endian agnostic _relaxed IO accessors instead of the __raw ones.
>
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Uncontroversial. Applied with Nicolas' ACK.

Yours,
Linus Walleij
