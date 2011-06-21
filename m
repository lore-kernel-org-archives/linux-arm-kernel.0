From: per.forlin@linaro.org (Per Forlin)
Date: Tue, 21 Jun 2011 10:09:16 +0200
Subject: [PATCH v6 00/11] mmc: use nonblock mmc requests to minimize
	latency
In-Reply-To: <20110621075319.GN26089@n2100.arm.linux.org.uk>
References: <1308518257-9783-1-git-send-email-per.forlin@linaro.org>
	<20110621075319.GN26089@n2100.arm.linux.org.uk>
Message-ID: <BANLkTikOA3G0Gt4Cxua3EDnAzbFKLAk6Yw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21 June 2011 09:53, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> On Sun, Jun 19, 2011 at 11:17:26PM +0200, Per Forlin wrote:
>> How significant is the cache maintenance over head?
>
> Per,
>
> Can you measure how much difference this has before and after your
> patch set please?
Absolutely, I can run the mmc_tests to get the measurement. The cache
affect is greater the faster the flash memory is. Currently I only
have access to a SD card (20 MiB/S). By the end of this week I can run
on eMMC (45 MiB/s) if this will be needed.

Thanks for your input,
Per
