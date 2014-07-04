From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 4 Jul 2014 23:33:40 +0200
Subject: [PATCH v3 2/4] pinctrl: sunxi: Move setting of mux to irq type
 from unmask to request_resources
In-Reply-To: <1404051062-24079-3-git-send-email-hdegoede@redhat.com>
References: <1404051062-24079-1-git-send-email-hdegoede@redhat.com>
 <1404051062-24079-3-git-send-email-hdegoede@redhat.com>
Message-ID: <CACRpkdYkSQ6XW8gG1MpGSX6B+RA7sOZxcOT9dTz549qa1SqaSA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 29, 2014 at 4:11 PM, Hans de Goede <hdegoede@redhat.com> wrote:

> With level triggered interrupt mask / unmask will get called for each
> interrupt, doing the somewhat expensive mux setting on each unmask thus is
> not a good idea. Instead add a request_resources callback and do it there.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Patch applied.

Yours,
Linus Walleij
