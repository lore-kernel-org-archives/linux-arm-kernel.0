From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 24 Feb 2014 11:06:12 +0100
Subject: [PATCH v4 03/16] pinctrl: mvebu: identify generic controls by name
In-Reply-To: <1393165274-32492-4-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1392220776-30851-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1393165274-32492-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1393165274-32492-4-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <CACRpkdZ3yYAfQkXdZ28fuVdsb6pVD9wui7S__qzSUO6WJiWH3Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 23, 2014 at 3:21 PM, Sebastian Hesselbarth
<sebastian.hesselbarth@gmail.com> wrote:

> We treat unnamed controls as generic mvebu mpp register controls but
> we identify them by not being special controls. Flip the logic and
> use the name pointer as identification instead. While at it, add some
> comments explaining the not so obvious treatment.
>
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Tested-by: Andrew Lunn <andrew@lunn.ch>
> Tested-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Patch applied.

Yours,
Linus Walleij
