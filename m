From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Thu, 11 Feb 2016 12:59:03 +0100
Subject: [PATCH V5 06/11] soc: mediatek: PMIC wrap: SPI_WRITE needs a
 different bitmask for MT2701/7623
In-Reply-To: <1454841778-35529-7-git-send-email-blogic@openwrt.org>
References: <1454841778-35529-1-git-send-email-blogic@openwrt.org>
 <1454841778-35529-7-git-send-email-blogic@openwrt.org>
Message-ID: <56BC7787.8070308@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 07/02/16 11:42, John Crispin wrote:
> MT2701 and MT7623 use a different bitmask for the SPI_WRITE command.
>

Something like:
Different SoCs will use different bitmask for the SPI_WRITE command. 
This patch defines the bitmask in the pmic_wrapper_type to allow an easy 
addition.

Well you are the native speaker, so maybe it's not the best to just use 
my version ;)

Regards,
Matthias
