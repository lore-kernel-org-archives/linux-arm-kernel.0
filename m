From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Sun, 12 May 2013 20:41:42 +0530
Subject: [RFC 22/42] drivers/rtc: don't check resource with
 devm_ioremap_resource
In-Reply-To: <1368173847-5661-23-git-send-email-wsa@the-dreams.de>
References: <1368173847-5661-1-git-send-email-wsa@the-dreams.de>
 <1368173847-5661-23-git-send-email-wsa@the-dreams.de>
Message-ID: <CAOh2x==r81YBYKWtPSUs=E35P_yfbCYjUib6EbPttYHME22cww@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 10, 2013 at 1:47 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> devm_ioremap_resource does sanity checks on the given resource. No need to
> duplicate this in the driver.
>
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> ---
>  drivers/rtc/rtc-spear.c  |    7 +------

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
