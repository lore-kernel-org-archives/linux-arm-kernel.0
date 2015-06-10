From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 10 Jun 2015 13:36:07 +0200
Subject: [PATCH 16/34] pinctrl: mvebu: armada-{370,375,38x,39x,xp}:
 normalize TDM pins
In-Reply-To: <1433868446-11028-17-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1433868446-11028-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1433868446-11028-17-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <CACRpkdbDYYUQvx+7da-zBNmM1Xjdfu=M2kpscaN4wsw7UAu9mQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 9, 2015 at 6:47 PM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:

> This commit normalizes the naming of the TDM pins accross the
> different Marvell SoCs. Mainly it consists in:
>
>  * Removing the 'n' from signal names: 'intn' becomes 'int' and 'rstn'
>    becomes 'rst'
>
>  * Renaming the main name 'tdm2c' to 'tdm' on Armada 38x.
>
>  * Change the main name 'tdm-1' to 'tdm' for one of the pins of the
>    Armada XP
>
> The last two changes affect DT compatibility, but since the TDM
> interface is nowhere near being supported in mainline, it should not
> be considered to be a serious problem at this point.
>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Patch applied.

Yours,
Linus Walleij
