From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Fri, 2 Jun 2017 14:32:39 +0200
Subject: [GIT PULL] ARM: realtek: arm64 for v4.12
In-Reply-To: <20170602002831.GO13314@localhost>
References: <20170525120404.32034-1-afaerber@suse.de>
 <20170602002831.GO13314@localhost>
Message-ID: <45e8f92d-0680-2983-067f-39adecf7503f@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

Am 02.06.2017 um 02:28 schrieb Olof Johansson:
> On Thu, May 25, 2017 at 02:04:03PM +0200, Andreas F??rber wrote:
>> Hi Arnd and Olof,
>>
>> This is the initial arm64 pull for Realtek.
>>
>> Regards,
>> Andreas
>>
>> The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:
>>
>>   Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)
>>
>> are available in the git repository at:
>>
>>   git://github.com/afaerber/linux.git tags/realtek-arm64-soc-for-4.12
> 
> This is v4.13 material at this point, so I've merged it into next/arm64 for
> the next merge window (v4.13). Thanks!

Arnd had told me to rebase onto v4.12-rc1 (from v4.11-rc1) but to not
wait for the 4.13 merge window. Therefore I submitted it for 4.12.
Miscommunication? Either way works for me.

Now that you have merged ARCH_REALTEK here, should we update the arm64
defconfig to enable it? I just verified on arm-soc.git for-next that's
it's disabled by default; the only other disabled ones are ARCH_BRCMSTB
and to-be-dropped ARCH_VULCAN. Question is, should it be useful to users
before we do so, or is build-testing enough of a reason?

Thanks,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
