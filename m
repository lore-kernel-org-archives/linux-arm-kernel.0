From: eric@eukrea.com (=?ISO-8859-1?Q?Eric_B=E9nard?=)
Date: Tue, 12 Oct 2010 17:16:31 +0200
Subject: [PATCH v3] imx-esdhc: update devices registration
In-Reply-To: <20101012150815.GO29673@pengutronix.de>
References: <20101012130435.GN29673@pengutronix.de>
	<1286895505-9325-1-git-send-email-eric@eukrea.com>
	<20101012150815.GO29673@pengutronix.de>
Message-ID: <4CB47BCF.3060709@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

Le 12/10/2010 17:08, Uwe Kleine-K?nig a ?crit :
>> +#define MX25_MMC_SDHC1_BASE_ADDR	0x53fb4000
>> +#define MX25_MMC_SDHC2_BASE_ADDR	0x53fb8000
> I wonder about the name in the reference manual.  Is it really MMC_SDHC
> for all socs?  I always wonder what it the best here (if they are named
> inconsitently there), have it equal over all SoCs or have it match the
> respective reference manual?!
>
reference manual, section Memory Map :
i.MX25 : eSDHC-x
i.MX35 : eSDHCv2-x
i.MX51 : ESDHC x

so the manual are not consistent ... "MMC_SDHC" seems easy to understand 
but of course we can have ESDHC, or SDHC or something else if you have a 
better name to suggest.

Eric
