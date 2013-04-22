From: cjb@laptop.org (Chris Ball)
Date: Mon, 22 Apr 2013 17:50:17 -0400
Subject: [PATCH 1/3] mmc: mvsdio: Support inverted CD and WP GPIO lines
In-Reply-To: <20130422214543.GJ29947@lunn.ch> (Andrew Lunn's message of "Mon,
 22 Apr 2013 23:45:43 +0200")
References: <1366660500-26835-1-git-send-email-gmbnomis@gmail.com>
 <1366660500-26835-2-git-send-email-gmbnomis@gmail.com>
 <87wqrutjss.fsf@octavius.laptop.org> <20130422203723.GI29947@lunn.ch>
 <20130422210949.GJ25724@titan.lakedaemon.net>
 <20130422214543.GJ29947@lunn.ch>
Message-ID: <87sj2iteue.fsf@octavius.laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Apr 22 2013, Andrew Lunn wrote:
>> Nothing else really jumps out though.  Where either of these what you
>> were thinking of?
>
> http://lists.infradead.org/pipermail/linux-arm-kernel/2012-December/138514.html
>
> and
>
> http://lists.infradead.org/pipermail/linux-arm-kernel/2012-December/138513.html

These patches move mvsdio to slot-gpio, which is a prerequisite for
using the shared mmc_of_parse(), but they don't go all the way to
using mmc_of_parse().

(Which makes sense; mmc_of_parse() was merged to mmc-next in February,
so it wasn't available for this patchset in December.)

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
