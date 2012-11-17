From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 18 Nov 2012 00:02:31 +0100
Subject: [PATCH 01/16] gpio: SPEAr: add spi chipselect control driver
In-Reply-To: <3702a1036f8e714e6d18e4726569bbb1eadd65bf.1353042873.git.viresh.kumar@linaro.org>
References: <4a92290e8a3b1a19c3a5e864edfa7badfc2af5d0.1352608333.git.viresh.kumar@linaro.org>
 <3702a1036f8e714e6d18e4726569bbb1eadd65bf.1353042873.git.viresh.kumar@linaro.org>
Message-ID: <CACRpkda89OGRwJ74QHvyKfdnufYdRn90A8YK5tf0Jc41RpUxJA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 16, 2012 at 6:15 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:

> From: Shiraz Hashim <shiraz.hashim@st.com>
>
> SPEAr platform provides a provision to control chipselects of ARM PL022
> Prime Cell spi controller through its system registers, which otherwise
> remains under PL022 control which some protocols do not want.
>
> This commit intends to provide the spi chipselect control in software over
> gpiolib interface. spi chip drivers can use the exported gpiolib interface to
> define their chipselect through DT or platform data.
>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Signed-off-by: Shiraz Hashim <shiraz.hashim@st.com>
> Reviewed-by: Vipin Kumar <vipin.kumar@st.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>
> Hi Grant,
>
> This patch was earlier sent as part of drivers/pinctrl/spear directory and after
> some discussion over mainline it is moved to gpio now. It is already reviewed by
> Linus and Arnd, though they haven't given their Reviewed-by's.

I've applied it to my gpio tree with Arnd's ACK, thanks!

Yours,
Linus Walleij
