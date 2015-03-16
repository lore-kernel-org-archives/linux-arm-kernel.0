From: afaerber@suse.de (=?UTF-8?B?QW5kcmVhcyBGw6RyYmVy?=)
Date: Mon, 16 Mar 2015 15:55:53 +0100
Subject: [PATCH] ARM: dts: Update exynos5250-spring with mmc node changes
In-Reply-To: <54E5CD2E.9070608@collabora.co.uk>
References: <1424275812-6797-1-git-send-email-afaerber@suse.de>
 <54E5CD2E.9070608@collabora.co.uk>
Message-ID: <5506EEF9.7080100@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 19.02.2015 um 12:46 schrieb Javier Martinez Canillas:
> Hello Andreas,
> 
> On 02/18/2015 05:10 PM, Andreas F?rber wrote:
>> Resolve a merge conflict with mmc refactoring aaa25a5a33cb ("ARM: dts:
>> unuse the slot-node and deprecate the supports-highspeed for dw-mmc in
>> exynos") by dropping the slot at 0 nodes, moving its bus-width property to
>> the mmc node and replacing supports-highspeed with cap-{mmc,sd}-highspeed,
>> matching exynos5250-snow.
>>
>> Cc: Jaehoon Chung <jh80.chung@samsung.com>
>> Fixes: 53dd4138bb0a ("ARM: dts: Add exynos5250-spring device tree")
>> Signed-off-by: Andreas F?rber <afaerber@suse.de>
>> ---
>>  arch/arm/boot/dts/exynos5250-spring.dts | 16 ++++------------
>>  1 file changed, 4 insertions(+), 12 deletions(-)
>>
> 
> Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Ping!

> 
> Best regards,
> Javier

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Jennifer Guild, Dilip Upmanyu,
Graham Norton; HRB 21284 (AG N?rnberg)
