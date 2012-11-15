From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 15 Nov 2012 18:34:15 +0100
Subject: [PATCH] pinctrl: nomadik: Staticize non-exported symbols
In-Reply-To: <1352995295.10636.1.camel@phoenix>
References: <1352995295.10636.1.camel@phoenix>
Message-ID: <CACRpkdapymohVKdpovB6V_noH+9E2daV+SbYUK2zPhro=6HUEw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 15, 2012 at 5:01 PM, Axel Lin <axel.lin@ingics.com> wrote:

> They are not referenced outside of this file, make them static.
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>

Applied with Lee's ACK, thanks!

Yours,
Linus Walleij
