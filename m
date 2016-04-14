From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Thu, 14 Apr 2016 18:08:10 +0530
Subject: [PATCH v3 09/16] phy: da8xx-usb: new driver for DA8xx SoC USB PHY
In-Reply-To: <570EA6EC.1040001@lechnology.com>
References: <1458863503-31121-1-git-send-email-david@lechnology.com>
 <1458863503-31121-10-git-send-email-david@lechnology.com>
 <570E4796.7070005@ti.com> <570EA6EC.1040001@lechnology.com>
Message-ID: <570F8F32.8050302@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thursday 14 April 2016 01:37 AM, David Lechner wrote:
> On 04/13/2016 08:20 AM, Kishon Vijay Abraham I wrote:
>>
>> Don't prefer export symbols from PHY driver. That'll create unnecessary
>> dependencies between the controller and the PHY.
>>
>> To see how to fix it, please see my comment for the previous version of your
>> patch.
>>
>> Thanks
>> Kishon
>>
> 
> 
> What is the proper way to give you credit for the changes you suggested?

Suggested-by: is commonly used. But if this patch goes via linux-phy tree, I'll
also add my Signed-off-by ;-)

Thanks
Kishon
