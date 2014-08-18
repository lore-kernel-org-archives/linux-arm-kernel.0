From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 18 Aug 2014 12:40:12 -0500
Subject: [PATCHv10 3/5] ARM: dts: exynos: unuse the slot-node and deprecate
 the supports-highspeed for dw-mmc
In-Reply-To: <53F23283.8040303@suse.de>
References: <1407397082-32495-1-git-send-email-jh80.chung@samsung.com>
 <1407397082-32495-4-git-send-email-jh80.chung@samsung.com>
 <53F1F027.7060609@samsung.com> <53F20955.2050806@suse.de>
 <53F22FBB.4010801@samsung.com> <53F23283.8040303@suse.de>
Message-ID: <53F23A7C.3060404@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/18/14 12:06, Andreas F?rber wrote:
> Am 18.08.2014 18:54, schrieb Kukjin Kim:
>> On 08/18/14 09:10, Andreas F?rber wrote:
>>> Hi Jaehoon,
>>>
>>> Am 18.08.2014 14:23, schrieb Jaehoon Chung:
>>>> Socfpga and Rockchip were queued into each SoC tree.
>>>> I want to know whether this patch is queued or not into Samsung-Soc
>>>> tree.
>>>> Do you have any other plan for this patch?
>>>
>>> It isn't applied in his tree:
>>>
>>> http://git.kernel.org/cgit/linux/kernel/git/kgene/linux-samsung.git/
>>>
>>> In fact Kukjin has not applied any patches for 3 weeks now, which likely
>>> means he's on vacation. I am hoping he will review this and the other
>>> pending conflicting patches to decide on a merge order and fix any
>>> trivial conflicts himself. ;)
>>>
>> Oh, I thought it has been queued in previous merge window with my ack.
>>
>> OK, I've applied this in my tree for 3.18.
>
> So, are you dropping the snow mmc pinctrl patch Doug asked you to queue
> before this one, and are you merging this with my exynos5250
> cros-common/style cleanups yourself or do I need yet another respin?
>
Hi Andreas,

Thanks for your gentle reminder and I think I can handle it when I apply 
it in my tree :)

Note I will check them today and if any problems, I'll let you know.

- Kukjin
