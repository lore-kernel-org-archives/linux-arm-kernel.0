From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Wed, 11 Jun 2014 15:14:25 +0530
Subject: [PATCH] phy: sun4i: depend on RESET_CONTROLLER
In-Reply-To: <20140611091035.GD4254@lukather>
References: <1400871088-16894-1-git-send-email-maxime.ripard@free-electrons.com>
 <20140611091035.GD4254@lukather>
Message-ID: <539824F9.6050302@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wednesday 11 June 2014 02:40 PM, Maxime Ripard wrote:
> Hi Kishon,
> 
> On Fri, May 23, 2014 at 08:51:28PM +0200, Maxime Ripard wrote:
>> The driver depend on the reset framework in a mandatory way. Make sure
>> reset_control_get is defined by adding this dependency in Kconfig
>>
>> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>> Reported-by: Arnd Bergmann <arnd@arndb.de>
> 
> Ping?

Will queue once -rc1 is tagged.

Cheers
Kishon

> 
> Maxime
> 
