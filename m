From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 14 Aug 2012 10:38:41 +0200
Subject: [PATCH 01/22] ARM: ux500: Fix merge error, no matching driver
 name for 'snd_soc_u8500'
In-Reply-To: <1344527268-5964-2-git-send-email-lee.jones@linaro.org>
References: <1344527268-5964-1-git-send-email-lee.jones@linaro.org>
 <1344527268-5964-2-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdb1CeoLa-+FAKRFwbXVbup_KFM_WTMrKUEGXtXqogZhWg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 9, 2012 at 5:47 PM, Lee Jones <lee.jones@linaro.org> wrote:

> The platform attempts to register platform device 'snd_soc_u8500'
> which doesn't actually exist. Here we change the reference to the
> correct one 'snd_soc_mop500'.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied to fixes. I will send this upstream for the -rc:s.

Yours,
Linus Walleij
