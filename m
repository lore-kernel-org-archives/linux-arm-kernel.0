From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Thu, 17 Oct 2013 19:55:24 +0200
Subject: [PATCH 1/1] irqchip: exynos: Remove hardcoded irqbase
In-Reply-To: <1382007881-1161-1-git-send-email-sachin.kamat@linaro.org>
References: <1382007881-1161-1-git-send-email-sachin.kamat@linaro.org>
Message-ID: <1392351.iKvAGkUsrS@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sachin,

On Thursday 17 of October 2013 16:34:41 Sachin Kamat wrote:
> Now that Exynos platforms are DT only, hard-coded irqbase is not
> necessary.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---
>  drivers/irqchip/exynos-combiner.c |    9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)

A patch like this has been already submitted by Chander Kashyap and it was 
supposed to be already applied by Kukjin:

http://thread.gmane.org/gmane.linux.kernel.samsung-soc/23312/focus=23442

I'm not sure why it is not yet in Samsung tree, so I pinged original 
thread.

Best regards,
Tomasz
