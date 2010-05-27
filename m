From: eric@eukrea.com (=?UTF-8?B?RXJpYyBCw6luYXJk?=)
Date: Thu, 27 May 2010 16:04:47 +0200
Subject: [PATCH v2 2/4] soc/imx: add eukrea-tlv320
In-Reply-To: <1274968205.3542.283.camel@odin>
References: <1274950737-26498-1-git-send-email-eric@eukrea.com>	
	<1274950737-26498-2-git-send-email-eric@eukrea.com>
	<1274968205.3542.283.camel@odin>
Message-ID: <4BFE7BFF.7010400@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Liam,

Le 27/05/2010 15:50, Liam Girdwood a ?crit :
>> +
>> +	eukrea_tlv320_dai.cpu_dai =&imx_ssi_pcm_dai[0];
>
> Any reason why this is not defined above ?
>
I plan to reuse this driver for iMX25, 35 & 51 based boards so this 
parameter may change depending on machine_is_xxx macro.

Eric
