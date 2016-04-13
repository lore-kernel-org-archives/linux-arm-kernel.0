From: david@lechnology.com (David Lechner)
Date: Wed, 13 Apr 2016 15:07:08 -0500
Subject: [PATCH v3 09/16] phy: da8xx-usb: new driver for DA8xx SoC USB PHY
In-Reply-To: <570E4796.7070005@ti.com>
References: <1458863503-31121-1-git-send-email-david@lechnology.com>
 <1458863503-31121-10-git-send-email-david@lechnology.com>
 <570E4796.7070005@ti.com>
Message-ID: <570EA6EC.1040001@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/13/2016 08:20 AM, Kishon Vijay Abraham I wrote:
>
> Don't prefer export symbols from PHY driver. That'll create unnecessary
> dependencies between the controller and the PHY.
>
> To see how to fix it, please see my comment for the previous version of your patch.
>
> Thanks
> Kishon
>


What is the proper way to give you credit for the changes you suggested?
