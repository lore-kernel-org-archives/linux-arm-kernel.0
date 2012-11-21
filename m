From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 21 Nov 2012 09:21:03 +0100
Subject: [PATCH V3 10/11] ARM: remove struct sys_timer suspend and resume
 fields
In-Reply-To: <1353349867-28494-11-git-send-email-swarren@wwwdotorg.org>
References: <1353349867-28494-1-git-send-email-swarren@wwwdotorg.org>
 <1353349867-28494-11-git-send-email-swarren@wwwdotorg.org>
Message-ID: <CACRpkdYBfh49qxfAi6Kt74rVbqSRCioF6O=87gXrhzK=3YR6TQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 19, 2012 at 7:31 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:

> From: Stephen Warren <swarren@nvidia.com>
>
> These fields duplicate e.g. struct clock_event_device's suspend and
> resume fields, so remove them now that nothing is using them. The aim
> is to remove all fields from struct sys_timer except .init, then replace
> the ARM machine descriptor's .timer field with a .init_time function
> instead, and delete struct sys_timer.
>
> Signed-off-by: Stephen Warren <swarren@nvidia.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
