From: philipp.zabel@gmail.com (Philipp Zabel)
Date: Tue, 6 Oct 2015 08:53:57 +0200
Subject: [PATCH 04/17] ARM: pxa: hx4700: Remove unused field initializers
In-Reply-To: <1444034997-9805-5-git-send-email-thierry.reding@gmail.com>
References: <1444034997-9805-1-git-send-email-thierry.reding@gmail.com>
 <1444034997-9805-5-git-send-email-thierry.reding@gmail.com>
Message-ID: <CA+gwMcevzM9UTpRd7vGQ9mOa4vr=hAq5ZBG7tSWq0mf21fDX3w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 5, 2015 at 10:49 AM, Thierry Reding
<thierry.reding@gmail.com> wrote:
> The ID and period for the backlight PWM are obtained from a PWM lookup
> table, so the corresponding values don't need to be duplicated into the
> platform data.
>
> Cc: Daniel Mack <daniel@zonque.org>
> Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
> Cc: Robert Jarzmik <robert.jarzmik@free.fr>
> Signed-off-by: Thierry Reding <thierry.reding@gmail.com>

Acked-by: Philipp Zabel <philipp.zabel@gmail.com>

regards
Philipp
