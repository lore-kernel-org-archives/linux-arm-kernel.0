From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 16 Apr 2012 10:34:12 +0200
Subject: [PATCH 1/7] ARM: ux500: Rename the DT compatible entry for i2c
 devices on Snowball
In-Reply-To: <1334325909-5779-2-git-send-email-lee.jones@linaro.org>
References: <1334325909-5779-1-git-send-email-lee.jones@linaro.org>
 <1334325909-5779-2-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkda4F0kWG67Vw7MJajghn5TGs-dzY90JAgf_=LU++TMx9A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 13, 2012 at 4:05 PM, Lee Jones <lee.jones@linaro.org> wrote:

> It is believed that the i2c compatible match entry is too long
> and cumbersome in its current form. This patch takes steps to
> decrease its length by using ST-Mircroelectrics' abbreviation ST.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied to ux500-core with speling cortecctions and Arnd's ACK.

Thanks,
Linus Walleij
