From: amit.kucheria@canonical.com (Amit Kucheria)
Date: Thu, 15 Dec 2011 09:28:54 +0530
Subject: [PATCH 16/19] eukrea-cpuimx51: remove board
In-Reply-To: <4EE7253E.2030604@eukrea.com>
References: <1323757911-25217-1-git-send-email-eric@eukrea.com>
 <1323757911-25217-16-git-send-email-eric@eukrea.com>
 <20111213100532.GH27267@pengutronix.de>
 <4EE7253E.2030604@eukrea.com>
Message-ID: <20111215035854.GA24039@avalanche>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11 Dec 13, Eric B?nard wrote:
> Hi Sascha,
> 
> Le 13/12/2011 11:05, Sascha Hauer a ?crit :
> >On Tue, Dec 13, 2011 at 07:31:48AM +0100, Eric B?nard wrote:
> >>this board is not maintained anymore and is replaced by cpuimx51sd
> >
> >I'm happy to remove this code, but aren't there any users of this board?
> >
> not any that would need a kernel upgrade considering the Freescale
> proprietary drivers used on it :-(
> Thanks,
> Eric

Just for posterity, could you list the drivers that make an upgrade
impossible?

IMHO, if these boards were sold commercially we should maintain support if
there is a chance that we will get open drivers in the future.

OTOH, if you can tell who each of these boards to, it is probably a good
target for removal. :)

/Amit

-- 
--------------------------------------------------------------------------------
Amit Kucheria, Power Management Tech Lead, Linaro || amit.kucheria at canonical.com
--------------------------------------------------------------------------------
