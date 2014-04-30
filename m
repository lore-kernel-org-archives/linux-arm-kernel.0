From: pawel.moll@arm.com (Pawel Moll)
Date: Wed, 30 Apr 2014 15:13:44 +0100
Subject: [PATCH 02/10] mfd: vexpress: Convert custom func API to regmap
In-Reply-To: <20140430135855.GO29462@lee--X1>
References: <1398707877-22596-1-git-send-email-pawel.moll@arm.com>
 <1398707877-22596-3-git-send-email-pawel.moll@arm.com>
 <20140430135855.GO29462@lee--X1>
Message-ID: <1398867224.24255.22.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2014-04-30 at 14:58 +0100, Lee Jones wrote:
> MFD diffstat looks great and the changes look sensible:
>   Acked-by: Lee Jones <lee.jones@linaro.org>

Thanks!

> I guess someone will need to create a branch for us all to pull from.
> I'm happy to do it if needs be.

I was thinking that, with enough acks (and I'm counting on one from you
for "[PATCH 04/10] mfd: vexpress: Define the device as MFD cells" :-),
merging the whole series (or at least patches 1-4 and 7-8) through
arm-soc tree would be the simplest option. I have no problem with the
independent bits (clk, clocksource, hwmon and the mfd/HBI change) going
through appropriate subsystems.

Pawe?
