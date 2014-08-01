From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Fri, 01 Aug 2014 21:20:52 +0300
Subject: [PATCH v2 1/2] spi: davinci: add support to configure gpio cs
 through dt
In-Reply-To: <20140801172620.GA30458@sirena.org.uk>
References: <1406911233-18999-1-git-send-email-grygorii.strashko@ti.com>
 <1406911233-18999-2-git-send-email-grygorii.strashko@ti.com>
 <20140801172620.GA30458@sirena.org.uk>
Message-ID: <53DBDA84.5010405@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/01/2014 08:26 PM, Mark Brown wrote:
> On Fri, Aug 01, 2014 at 07:40:32PM +0300, Grygorii Strashko wrote:
>> From: Murali Karicheri <m-karicheri2@ti.com>
>>
>> Currently driver supports only configuration of GPIO CS through
>> platform data. This patch enhances the driver to configure GPIO
>> CS through DT. Also update the DT binding documentation to
>> reflect the availability of cs-gpios.
>
> Please submit an incremental patch with whatever the changes were from
> the version of this that I applied already.
>

This series is based on top of:
"[PATCH 1/2] spi: davinci: fix to support more than 2 chip selects"
http://www.spinics.net/lists/linux-spi/msg01447.html

Sorry, I've forgot to mention this in cover letter.
Is that what you mean?

regards,
-grygorii
