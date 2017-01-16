From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Mon, 16 Jan 2017 14:47:46 +0530
Subject: [PATCH 0/6] USB support for Broadcom NSP SoC
In-Reply-To: <79483fc3-5e91-a1f0-1dbf-1987682373e6@gmail.com>
References: <1478683994-12008-1-git-send-email-yendapally.reddy@broadcom.com>
 <79483fc3-5e91-a1f0-1dbf-1987682373e6@gmail.com>
Message-ID: <587C8FBA.7010802@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Tuesday 13 December 2016 07:50 AM, Florian Fainelli wrote:
> On 11/09/2016 01:33 AM, Yendapally Reddy Dhananjaya Reddy wrote:
>> This patch set contains the usb support for Broadcom NSP SoC.
>> The usb phy is connected through mdio interface. The mdio interface
>> can be used to access either internal phys or external phys using a
>> multiplexer.
>>
>> The first patch provides the documentation details for mdio-mux and
>> second patch provides the documentation details for usb3 phy. The third
>> patch contains the mdio-mux support and fourth patch contains the
>> changes to the mdio bus driver.
>>
>> The fifth patch provides the phy driver and sixth patch provides the
>> enable method for usb.
>>
>> This patch series has been tested on NSP bcm958625HR board.
>> This patch series is based on v4.9.0-rc1 and is available from github-
>> repo: https://github.com/Broadcom/cygnus-linux.git
>> branch:nsp-usb-v1
> 
> Can you resubmit this patch series with the feedback from Andrew, Rob
> and Scott addressed?

can the phy patches be re-submitted based on latest mainline and addressing
those feedbacks?

Thanks
Kishon
