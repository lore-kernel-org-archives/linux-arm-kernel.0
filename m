From: james.hogan@imgtec.com (James Hogan)
Date: Mon, 29 Apr 2013 17:00:13 +0100
Subject: [v8,01/12] gpio: add gpio offset in gpio range cells property
In-Reply-To: <1359825953-15663-2-git-send-email-haojian.zhuang@linaro.org>
References: <1359825953-15663-2-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <517E990D.10101@imgtec.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/02/13 17:25, Haojian Zhuang wrote:
> Add gpio offset into "gpio-range-cells" property. It's used to support
> sparse pinctrl range in gpio chip.
> 
> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

This is an ABI breakage. I've been using the #gpio-range-cells = <2>
since around October. Please can we try and maintain backward
compatibility in future, even if it's only temporary.

Thanks
James
