From: afaerber@suse.de (=?ISO-8859-1?Q?Andreas_F=E4rber?=)
Date: Mon, 18 Aug 2014 19:06:11 +0200
Subject: [PATCHv10 3/5] ARM: dts: exynos: unuse the slot-node and deprecate
 the supports-highspeed for dw-mmc
In-Reply-To: <53F22FBB.4010801@samsung.com>
References: <1407397082-32495-1-git-send-email-jh80.chung@samsung.com>
 <1407397082-32495-4-git-send-email-jh80.chung@samsung.com>
 <53F1F027.7060609@samsung.com> <53F20955.2050806@suse.de>
 <53F22FBB.4010801@samsung.com>
Message-ID: <53F23283.8040303@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 18.08.2014 18:54, schrieb Kukjin Kim:
> On 08/18/14 09:10, Andreas F?rber wrote:
>> Hi Jaehoon,
>>
>> Am 18.08.2014 14:23, schrieb Jaehoon Chung:
>>> Socfpga and Rockchip were queued into each SoC tree.
>>> I want to know whether this patch is queued or not into Samsung-Soc
>>> tree.
>>> Do you have any other plan for this patch?
>>
>> It isn't applied in his tree:
>>
>> http://git.kernel.org/cgit/linux/kernel/git/kgene/linux-samsung.git/
>>
>> In fact Kukjin has not applied any patches for 3 weeks now, which likely
>> means he's on vacation. I am hoping he will review this and the other
>> pending conflicting patches to decide on a merge order and fix any
>> trivial conflicts himself. ;)
>>
> Oh, I thought it has been queued in previous merge window with my ack.
> 
> OK, I've applied this in my tree for 3.18.

So, are you dropping the snow mmc pinctrl patch Doug asked you to queue
before this one, and are you merging this with my exynos5250
cros-common/style cleanups yourself or do I need yet another respin?

Andreas

-- 
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend?rffer; HRB 16746 AG N?rnberg
