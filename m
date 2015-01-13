From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 13 Jan 2015 15:29:38 +0100
Subject: [PATCH v2 01/13] pinctrl: sun6i: Add some missing functions
In-Reply-To: <1418836704-15689-2-git-send-email-hdegoede@redhat.com>
References: <1418836704-15689-1-git-send-email-hdegoede@redhat.com>
 <1418836704-15689-2-git-send-email-hdegoede@redhat.com>
Message-ID: <CACRpkdZMv0VNjSmhB0VoGt=wo02+g56YQtekD9MnxYUSmJDXEw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 17, 2014 at 6:18 PM, Hans de Goede <hdegoede@redhat.com> wrote:

> While working on pinctrl for the A31s, I noticed that function 4 of
> PA15 - PA18 was missing, add these.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> -Drop the changes to the muxing of i2c3 this was based on
>  "A31s Datasheet v1.40.pdf", but all other A31 related info puts them at the
>  pins where we already have them, so leave this as is

Patch applied with Maxime's ACK.

Yours,
Linus Walleij
