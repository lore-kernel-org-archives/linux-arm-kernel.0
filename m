From: eric@eukrea.com (=?ISO-8859-1?Q?Eric_B=E9nard?=)
Date: Thu, 18 Nov 2010 09:43:06 +0100
Subject: [PATCH 00/51] some more imx patches for 2.6.38
In-Reply-To: <20101117212821.GF8942@pengutronix.de>
References: <20101117212821.GF8942@pengutronix.de>
Message-ID: <4CE4E71A.2080909@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

On 17/11/2010 22:28, Uwe Kleine-K?nig wrote:
> The highlights are that for most devices for i.MX1, i.MX21, i.MX25 and
> i.MX27 are allocated dynamically which reduces the memory footprint of
> the kernel.  Moreover I moved support for i.MX25 to mach-imx targeting a
> multi-SoC-kernel for i.MX.
>
do you have numbers concerning the memory footprint savings ?

Thanks
Eric
