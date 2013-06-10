From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 10 Jun 2013 17:18:42 +0200
Subject: [PATCH 02/10] ARM: ux500: Provide a supply name for the AB8500
 AUX regulators to use
In-Reply-To: <1370621488-18130-3-git-send-email-lee.jones@linaro.org>
References: <1370621488-18130-1-git-send-email-lee.jones@linaro.org>
 <1370621488-18130-3-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdZWc74MQqUdXbW=cEgzHbC7Og==Tq1iEbhQSeG891BWrA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 7, 2013 at 6:11 PM, Lee Jones <lee.jones@linaro.org> wrote:

> AB8500 AUX regulators are supplied by EXT3 on some boards. This supply
> phandle lookup will enable the regulator core to search for and locate
> the EXT3 supply at registration time.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Patch applied to my ux500-devicetree branch.

Yours,
Linus Walleij
