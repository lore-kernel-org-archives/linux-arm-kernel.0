From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 27 Oct 2014 17:43:17 +0100
Subject: [PATCH 02/12] dmaengine: coh901318: use dmaengine_terminate_all()
 API
In-Reply-To: <1413042040-28222-2-git-send-email-vinod.koul@intel.com>
References: <1413041973-28146-1-git-send-email-vinod.koul@intel.com>
 <1413042040-28222-2-git-send-email-vinod.koul@intel.com>
Message-ID: <CACRpkdZyF77pmigQ=VnJYDV4k_SrRx7WyvwVPJfj9EVsugPwSg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 11, 2014 at 5:40 PM, Vinod Koul <vinod.koul@intel.com> wrote:

> The drivers should use dmaengine_terminate_all() API instead of accessing
> the device_control which will be deprecated soon
>
> Signed-off-by: Vinod Koul <vinod.koul@intel.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
