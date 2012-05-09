From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 9 May 2012 10:51:56 +0200
Subject: [PATCH 07/15] drivers/power: Carry out platform_data error
 checking on ab8500 devices
In-Reply-To: <1336155805-18554-8-git-send-email-lee.jones@linaro.org>
References: <1336155805-18554-1-git-send-email-lee.jones@linaro.org>
 <1336155805-18554-8-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdYkqj6Zr=05Byk+tPc1ohjfDoZKCkTmu9zcZpgKxV8wpg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 4, 2012 at 8:23 PM, Lee Jones <lee.jones@linaro.org> wrote:

> In their current state the ab8500 power devices explode if platform data
> isn't provided. This patch prevents this from happening and informs the
> user of what has happened.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

This or equivalent is already submitted and merged by Anton into the
power tree I think?

Yours,
Linus Walleij
