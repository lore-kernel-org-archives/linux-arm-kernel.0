From: lars@metafoo.de (Lars-Peter Clausen)
Date: Tue, 21 May 2013 20:23:16 +0200
Subject: [PATCH v4] ASoC: dfbmcs320: make the driver common for other
 BT modules
In-Reply-To: <1368879900-28395-1-git-send-email-Baohua.Song@csr.com>
References: <1368879900-28395-1-git-send-email-Baohua.Song@csr.com>
Message-ID: <519BBB94.5010408@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/18/2013 02:25 PM, Barry Song wrote:
> DFBM-CS320 is only one of bluetooth modules using CSR bluetooth chips, we
> don't want everyone to have a seperate codec driver. anyway, the feature
> of Bluetooth SCO is same on all platforms, so this patch makes the
> DFBM-CS320 driver become a common BT SCO link driver.
> 
> Cc: Graeme Gregory <graeme@openmoko.org> Cc: Lars-Peter Clausen
> <lars@metafoo.de> Signed-off-by: Barry Song <Baohua.Song@csr.com> --- v4: 
> change "select SND_SOC_DFBMCS320" to "select SND_SOC_BT_SCO" for OpenMOKO
> user as v3 missed this
> 

Looks good to me.

Acked-by: Lars-Peter Clausen <lars@metafoo.de>
