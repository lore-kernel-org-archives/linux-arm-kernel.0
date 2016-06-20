From: david.wu@rock-chips.com (David.Wu)
Date: Mon, 20 Jun 2016 10:18:19 +0800
Subject: [PATCH v10 0/8] add i2c driver supported for rk3399
In-Reply-To: <20160617115611.GC6876@tetsubishi>
References: <1463407063-41218-1-git-send-email-david.wu@rock-chips.com>
 <20160617115611.GC6876@tetsubishi>
Message-ID: <cc893dec-0796-d5f4-4702-bebd6d8819d7@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram?

? 2016/6/17 19:56, Wolfram Sang ??:
> Applied whole series to for-next, thanks! This was nicely refactored and
> easy to review, thanks. Also thanks to all reviewers who helped this
> series. I fixed one checkpatch issue for you, though:
>
> WARNING: Statements should start on a tabstop
> #278: FILE: drivers/i2c/busses/i2c-rk3x.c:789:
> +	 if (min_div_for_hold >= min_total_div) {
>

Thanks for your final review?
