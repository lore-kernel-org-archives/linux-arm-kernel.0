From: kbaidarov@dev.rtsoft.ru (Konstantin Baydarov)
Date: Wed, 25 Jul 2012 15:17:48 +0400
Subject: [PATCH v4 1/4] ARM: OMAP4: Remove un-used control module headers
 and defines.
In-Reply-To: <20120725110635.GE16794@arwen.pp.htv.fi>
References: <500FD2E9.8050408@dev.rtsoft.ru>
 <20120725110635.GE16794@arwen.pp.htv.fi>
Message-ID: <500FD5DC.7010002@dev.rtsoft.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

  Hi, Balbi.

On 07/25/2012 03:06 PM, Felipe Balbi wrote:
> Hi,
>
> On Wed, Jul 25, 2012 at 03:05:13PM +0400, Konstantin Baydarov wrote:
>> Most of the OMAP4 control module register defines are not used and
>> can be removed. Keep only needed defines and move them to common
>> control module header just like other OMAP versions.
>>
>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
>> Signed-off-by: Konstantin Baydarov <kbaidarov@dev.rtsoft.ru>
> Wasn't this one authored by Santosh ?? Where's his From: Santosh
> Shilimkar ???

I hit "edit as new" when I sent patches through thunderbird, I'll fix in the next series.

  BR,
    Konstantin Baydarov.

>
