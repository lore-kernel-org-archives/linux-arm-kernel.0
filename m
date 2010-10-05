From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 5 Oct 2010 19:40:15 +0200
Subject: [PATCH/RFC] i.MX31 and i.MX35 : fix errate TLSbo65953 and
	ENGcm09472
In-Reply-To: <4CAB56E3.8000402@eukrea.com>
References: <4CAAD39C.2010103@eukrea.com>
	<1286270739-18270-1-git-send-email-eric@eukrea.com>
	<20101005162920.GT11737@pengutronix.de>
	<4CAB56E3.8000402@eukrea.com>
Message-ID: <20101005174015.GU11737@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

On Tue, Oct 05, 2010 at 06:48:35PM +0200, Eric B?nard wrote:
> Le 05/10/2010 18:29, Uwe Kleine-K?nig a ?crit :
>> No.  When we start to have multi-soc support for imx and a kernel for
>> both mx35 and mxc91231 is compiled mxc91231_prepare_idle isn't called
>> anymore for mxc91231.  Ah, and cpu_do_idle isn't called anymore at all.
>>
> isn't that patch better ?
> http://lists.infradead.org/pipermail/linux-arm-kernel/2010-October/027983.html
Yes, but it doesn't address all my comments.  Sorry, I only saw it when
I already sent my reply to the first version.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
