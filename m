From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 10 Jun 2015 13:57:56 +0200
Subject: [PATCH 21/34] pinctrl: mvebu: armada-370: align VDD cpu-pd pin
 naming with datasheet
In-Reply-To: <1433868446-11028-22-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1433868446-11028-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1433868446-11028-22-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <CACRpkdY8mNLNNUAbG4MqtxikWsLBBgHfqBPk6WksRJ+KEPni2Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 9, 2015 at 6:47 PM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:

> For consistency with the datasheet, this commit renames the VDD
> function of the MPP4 pin.
>
> While this changes the DT compatibility, it is not considered to be a
> problem since this pin is unlikely to be used for anything but
> debugging purposes.
>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Patch applied.

Yours,
Linus Walleij
