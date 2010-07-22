From: eric@eukrea.com (=?ISO-8859-1?Q?Eric_B=E9nard?=)
Date: Thu, 22 Jul 2010 16:27:55 +0200
Subject: [PATCH 3/3] i.MX51: add support for cpuimx51 module and
	its	baseboard
In-Reply-To: <20100722133141.GL14113@pengutronix.de>
References: <1279610174-6025-1-git-send-email-eric@eukrea.com>	<1279610174-6025-2-git-send-email-eric@eukrea.com>	<1279610174-6025-3-git-send-email-eric@eukrea.com>
	<20100722133141.GL14113@pengutronix.de>
Message-ID: <4C48556B.7010100@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

Le 22/07/2010 15:31, Sascha Hauer a ?crit :
>> +
>> +extern void eukrea_mbimx51_baseboard_init(void);
>
> I'm not entirely happy with this. I think this should be in a file with
> "baseboard" in its file name rather than being named after the board. I
> realized you have the prototype for the baseboard init function for
> other eukrea boards in board specific header files aswell. How about
> creating a single eukrea-baseboards.h file where all available eukrea
> baseboards are combined?
>
OK, is it possible that you apply this patch :
http://lists.infradead.org/pipermail/linux-arm-kernel/2010-July/020755.html
then I'll merge all the .h in one and add the i.MX51 on top of this.

Thanks
Eric
