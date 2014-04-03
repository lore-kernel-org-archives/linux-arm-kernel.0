From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 3 Apr 2014 16:10:46 +0200
Subject: [PATCH] pinctrl: rockchip: fix offset of mux registers for rk3188
In-Reply-To: <1395700561-3793-1-git-send-email-b.galvani@gmail.com>
References: <1395700561-3793-1-git-send-email-b.galvani@gmail.com>
Message-ID: <CACRpkda9Lh19sfkxs3=dNWbg4FgkAtY2tJdMQik=TGs8wUkYfA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 24, 2014 at 11:36 PM, Beniamino Galvani <b.galvani@gmail.com> wrote:

> The correct value of .mux_offset for rk3188 seems to be 0x60
> instead of 0x68.
>
> Signed-off-by: Beniamino Galvani <b.galvani@gmail.com>

Patch applied to fixes with Heiko's Review tag and also
copied some info from the conversation into the commit message.

Yours,
Linus Walleij
