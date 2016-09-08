From: john.stultz@linaro.org (John Stultz)
Date: Thu, 8 Sep 2016 12:04:11 -0700
Subject: [PATCH 1/3] config: android: move device mapper options to
 recommended
In-Reply-To: <20160908185934.18098-1-robh@kernel.org>
References: <20160908185934.18098-1-robh@kernel.org>
Message-ID: <CALAqxLXHwSSdGZ_NhXLGKmtPjif3wUMAnOkv46R6+JQPveihEA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 8, 2016 at 11:59 AM, Rob Herring <robh@kernel.org> wrote:
> CONFIG_MD is in recommended, but other dependent options like DM_CRYPT
> and DM_VERITY options are in base. The result is the options in base don't
> get enabled when applying both base and recommended fragments. Move all
> the options to recommended.
>
> Signed-off-by: Rob Herring <robh@kernel.org>

Acked-by: John Stultz <john.stultz@linaro.org>

thanks
-john
