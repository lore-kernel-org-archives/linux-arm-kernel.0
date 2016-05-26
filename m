From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 26 May 2016 11:28:44 +0200
Subject: [PATCH 0/7] pinctrl: meson: Add a bunch more pins
In-Reply-To: <m260u3ia37.fsf@baylibre.com>
References: <1462544486-9516-1-git-send-email-khilman@baylibre.com>
 <CACRpkdY9oGZLt431NwTaFmZk98O8n3ZnMA1odhYZtcH7P1p=Jg@mail.gmail.com>
 <m260u3ia37.fsf@baylibre.com>
Message-ID: <CACRpkdbURowJNT_ZkKuv7C_3oW3BJGPBK6etKc4cBc4ujQdPXw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 24, 2016 at 8:29 PM, Kevin Hilman <khilman@baylibre.com> wrote:
> Linus Walleij <linus.walleij@linaro.org> writes:

> Looking closer, these have dependencies on the DT changes that you've
> suggested we take through arm-soc, so it would be cleaner if I take
> these with your ack through the amlogic tree.

I really prefer to take DT changes and driver code in different
trees i possible.

My reasoning is plainly: if the DT stuff was a separate git, as
has been explicitly suggested as a goal off and on, this should
be merge:able still. So DT changes and driver code should ideally
be orthogonal.

I don't know about this case but is it a disaster if one or the other
of the DT changes and the driver arrive in different order to Torvald's
tree, or will it simply be that the lights go on when the last patch
arrives?

Yours,
Linus Walleij
