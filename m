From: alex.elder@linaro.org (Alex Elder)
Date: Sun, 29 Dec 2013 23:59:40 -0600
Subject: [PATCH] clk: support hardware-specific debugfs entries
In-Reply-To: <1388383130-8029-1-git-send-email-elder@linaro.org>
References: <1388383130-8029-1-git-send-email-elder@linaro.org>
Message-ID: <52C10BCC.2030907@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/29/2013 11:58 PM, Alex Elder wrote:
> Add a new clk_ops->debug_init method to allow a clock hardware
> driver to populate the clock's debugfs directory with entries
> beyond those common for every clock.

Sorry, forgot to indicate "v2" in the Subject line...	-Alex

> Signed-off-by: Alex Elder <elder@linaro.org>
> ---
> v2: - Define debug_init unconditionally (suggested by Gerhard Sittig).
