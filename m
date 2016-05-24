From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 24 May 2016 11:23:37 +0200
Subject: [PATCH 0/7] pinctrl: meson: Add a bunch more pins
In-Reply-To: <1462544486-9516-1-git-send-email-khilman@baylibre.com>
References: <1462544486-9516-1-git-send-email-khilman@baylibre.com>
Message-ID: <CACRpkdY9oGZLt431NwTaFmZk98O8n3ZnMA1odhYZtcH7P1p=Jg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 6, 2016 at 4:21 PM, Kevin Hilman <khilman@baylibre.com> wrote:

> Add support for several more devices, both in the EE domain and in the
> AO domain.  Also, add the pins to the corresponding DTS files.
>
> Tested on odroid-c2 and Amlogic P200 boards, and verified with working
> ethernet.
>
> Depends on the initial GXBB pinctrl support from Carlo[1].  Also
> available in my git tree[2] with all the dependencies included.

These don't apply anomore sadly, Kevin can you rebase on
Torvalds' HEAD and resend, and include Carlo's ACK on them
so I can merge them in the next kernel cycle?

Yours,
Linus Walleij
