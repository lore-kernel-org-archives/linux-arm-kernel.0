From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 18 Oct 2012 20:29:51 +0200
Subject: [PATCH 07/10] pinctrl: remove mutex lock in groups show
In-Reply-To: <1350551224-12857-7-git-send-email-haojian.zhuang@gmail.com>
References: <1350551224-12857-1-git-send-email-haojian.zhuang@gmail.com>
 <1350551224-12857-7-git-send-email-haojian.zhuang@gmail.com>
Message-ID: <CACRpkdYDe1ODiXbV8JSmzwqVHTasY1TfkWZ0GFYQqORog4x52A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 18, 2012 at 11:07 AM, Haojian Zhuang
<haojian.zhuang@gmail.com> wrote:

> Mutex is locked duplicatly by pinconf_groups_show() and
> pin_config_group_get(). It results dead lock. So avoid to lock mutex
> in pinconf_groups_show().
>
> Signed-off-by: Haojian Zhuang <haojian.zhuang@gmail.com>

Thanks! Applied to my fixes branch with a Cc: stable tag.

Yours,
Linus Walleij
