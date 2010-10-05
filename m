From: eric@eukrea.com (=?ISO-8859-1?Q?Eric_B=E9nard?=)
Date: Tue, 05 Oct 2010 18:48:35 +0200
Subject: [PATCH/RFC] i.MX31 and i.MX35 : fix errate TLSbo65953
	and	ENGcm09472
In-Reply-To: <20101005162920.GT11737@pengutronix.de>
References: <4CAAD39C.2010103@eukrea.com>	<1286270739-18270-1-git-send-email-eric@eukrea.com>
	<20101005162920.GT11737@pengutronix.de>
Message-ID: <4CAB56E3.8000402@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

Le 05/10/2010 18:29, Uwe Kleine-K?nig a ?crit :
> No.  When we start to have multi-soc support for imx and a kernel for
> both mx35 and mxc91231 is compiled mxc91231_prepare_idle isn't called
> anymore for mxc91231.  Ah, and cpu_do_idle isn't called anymore at all.
>
isn't that patch better ?
http://lists.infradead.org/pipermail/linux-arm-kernel/2010-October/027983.html

Eric
