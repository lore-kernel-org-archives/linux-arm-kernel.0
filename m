From: sassmann@kpanic.de (Stefan Assmann)
Date: Thu, 31 Jul 2014 10:46:30 +0200
Subject: [PATCH 1/2] mfd: twl-core: move TWL6030 defines to twl.h
In-Reply-To: <20140731083611.GI9030@lee--X1>
References: <1406728949-7560-1-git-send-email-sassmann@kpanic.de>
 <1406728949-7560-2-git-send-email-sassmann@kpanic.de>
 <20140731083611.GI9030@lee--X1>
Message-ID: <53DA0266.6080807@kpanic.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31.07.2014 10:36, Lee Jones wrote:
> On Wed, 30 Jul 2014, Stefan Assmann wrote:
> 
>> These defines should be available to all drivers. Also added register
>> offset for CLK32KG_CFG_STATE and GRP defines.
>>
>> Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
>> ---
>>  drivers/regulator/twl-regulator.c | 11 -----------
>>  include/linux/i2c/twl.h           | 20 ++++++++++++++++++++
>>  2 files changed, 20 insertions(+), 11 deletions(-)
> 
> This doesn't have anything to do with MFD?
> 

I added mfd because many other commits in include/linux/i2c/twl.h
reference it. We can drop it if you like.

  Stefan
