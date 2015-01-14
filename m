From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Wed, 14 Jan 2015 12:57:51 +0100
Subject: [PATCH v2 16/16] ARM: dts: Fix I2S1,
 I2S2 compatible for exynos4 SoCs
In-Reply-To: <20150106181517.GQ2634@sirena.org.uk>
References: <1418997336-17777-1-git-send-email-s.nawrocki@samsung.com>
 <1418997336-17777-17-git-send-email-s.nawrocki@samsung.com>
 <20150106181517.GQ2634@sirena.org.uk>
Message-ID: <54B659BF.4000803@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/01/15 19:15, Mark Brown wrote:
> On Fri, Dec 19, 2014 at 02:55:36PM +0100, Sylwester Nawrocki wrote:
>> > I2S1, I2S2 on Exynos4 SoC series have limited functionality compared
>> > to I2S0, "samsung,s3c6410-i2s" compatible should be used for them.
>> > 
>> > Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
>> > ---
>
> This should probably go to stable as a bug fix too.

Sounds like a reasonable thing to do, I will Cc stable in next iteration.
