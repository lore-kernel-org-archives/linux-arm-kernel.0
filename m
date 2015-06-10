From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 10 Jun 2015 14:09:24 +0200
Subject: [PATCH 24/34] pinctrl: mvebu: armada-39x: normalize ref clock
 naming
In-Reply-To: <1433868446-11028-25-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1433868446-11028-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1433868446-11028-25-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <CACRpkdYnqVVKoQR8NsCQ-whaxbOx3R=XWZeqsMwDbnond_+9zw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 9, 2015 at 6:47 PM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:

> This commit normalizes the subnames of the reference clock MPP pins in
> the Armada 39x pinctrl driver to match with the name used on other
> SoCs.
>
> Since only the subnames are changed, DT backward compatibility is not
> affected.
>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Patch applied.

Yours,
Linus Walleij
