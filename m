From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 29 Jun 2012 11:03:18 +0800
Subject: [PATCH 1/3] ARM: imx6q: add clocks for gpmi-nand
In-Reply-To: <4FED1996.9080908@freescale.com>
References: <1340941925-14591-1-git-send-email-shijie8@gmail.com>
 <20120629022903.GB5844@shlinux2.ap.freescale.net>
 <4FED1996.9080908@freescale.com>
Message-ID: <20120629030315.GA29197@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 29, 2012 at 10:57:26AM +0800, Huang Shijie wrote:
> ? 2012?06?29? 10:29, Dong Aisheng ??:
> >We had several gpmi clocks here, so i guess it would be good if we have
> >the con_id set here too to distinguish what's this clock for.
> >
> thanks.
> But this will cause the mx28 can not find the clock.
> 
Hmm, it should not, as long as the con_id in imx28 gpmi-nand lookup
is NULL, which is a wildcard for matching.

-- 
Regards,
Shawn
