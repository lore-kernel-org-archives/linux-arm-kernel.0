From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 16 Oct 2015 16:43:41 +0200
Subject: [PATCH RESEND] pinctrl: berlin: fix BG2CD field widths
In-Reply-To: <1444164997-7746-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <CACRpkdaYGUkq-QqCtzph-aoYOzCfCgQ5JSAcNDjBeBLoZ0i_iA@mail.gmail.com>
 <1444164997-7746-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <CACRpkdYydJcG4+Pm9V6bZ908OeASeZz6RtFxqpJNmXnubgmEog@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 6, 2015 at 10:56 PM, Sebastian Hesselbarth
<sebastian.hesselbarth@gmail.com> wrote:

> From: Thomas Hebb <tommyhebb@gmail.com>
>
> The previous register layout was incorrect, many of the fields having
> fewer bits than were needed to represent all their modes. The new layout
> is taken from the bootloader source of a BG2CD device.
>
> Signed-off-by: Thomas Hebb <tommyhebb@gmail.com>
> Acked-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> ---
> Linus,
>
> this is the fix from Thomas rebased on v4.3-rc1.

Patch applied. Strangely it applied cleanly despite all the other
Berlin pinctrl development from Antoine and Jisheng!

Yours,
Linus Walleij
