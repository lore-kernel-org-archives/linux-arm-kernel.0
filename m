From: kgene@kernel.org (Kukjin Kim)
Date: Wed, 18 Mar 2015 01:27:49 +0900
Subject: [PATCH] ARM: dts: Update exynos5250-spring with mmc node changes
In-Reply-To: <5506EEF9.7080100@suse.de>
References: <1424275812-6797-1-git-send-email-afaerber@suse.de>
 <54E5CD2E.9070608@collabora.co.uk> <5506EEF9.7080100@suse.de>
Message-ID: <55085605.2000001@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/16/15 23:55, Andreas F?rber wrote:
> Am 19.02.2015 um 12:46 schrieb Javier Martinez Canillas:
>> Hello Andreas,
>>
Hi,

>> On 02/18/2015 05:10 PM, Andreas F?rber wrote:
>>> Resolve a merge conflict with mmc refactoring aaa25a5a33cb ("ARM: dts:
>>> unuse the slot-node and deprecate the supports-highspeed for dw-mmc in
>>> exynos") by dropping the slot at 0 nodes, moving its bus-width property to
>>> the mmc node and replacing supports-highspeed with cap-{mmc,sd}-highspeed,
>>> matching exynos5250-snow.
>>>
>>> Cc: Jaehoon Chung <jh80.chung@samsung.com>
>>> Fixes: 53dd4138bb0a ("ARM: dts: Add exynos5250-spring device tree")
>>> Signed-off-by: Andreas F?rber <afaerber@suse.de>
>>> ---
>>>  arch/arm/boot/dts/exynos5250-spring.dts | 16 ++++------------
>>>  1 file changed, 4 insertions(+), 12 deletions(-)
>>>
>>
>> Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> 
> Ping!
> 
Thanks, applied with 'Cc: <stable@vger.kernel.org> [3.19+]'

- Kukjin
