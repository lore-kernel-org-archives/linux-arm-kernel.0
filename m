From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Tue, 21 May 2013 10:31:09 +0530
Subject: [PATCH v6 0/9] Generic PHY Framework
In-Reply-To: <1367229812-30574-1-git-send-email-kishon@ti.com>
References: <1367229812-30574-1-git-send-email-kishon@ti.com>
Message-ID: <519AFF95.9060002@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Monday 29 April 2013 03:33 PM, Kishon Vijay Abraham I wrote:
> Added a generic PHY framework that provides a set of APIs for the PHY drivers
> to create/destroy a PHY and APIs for the PHY users to obtain a reference to
> the PHY with or without using phandle.
>
> This framework will be of use only to devices that uses external PHY (PHY
> functionality is not embedded within the controller).
>
> The intention of creating this framework is to bring the phy drivers spread
> all over the Linux kernel to drivers/phy to increase code re-use and to
> increase code maintainability.
>
> Comments to make PHY as bus wasn't done because PHY devices can be part of
> other bus and making a same device attached to multiple bus leads to bad
> design.
>
> If the PHY driver has to send notification on connect/disconnect, the PHY
> driver should make use of the extcon framework. Using this susbsystem
> to use extcon framwork will have to be analysed.
>
> Making omap-usb2 and twl4030 to use this framework is provided as a sample.
>
> This patch series is developed on linux-next tree.

Any comments on this patch series?

Thanks
Kishon
