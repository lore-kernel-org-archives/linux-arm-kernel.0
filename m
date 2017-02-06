From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Mon, 6 Feb 2017 11:49:53 +0100
Subject: [PATCH v2] ARM: dts: imx: Pass 'chosen' and 'memory' nodes
In-Reply-To: <6d3e9733-bebc-4347-95db-2a1c9018948d@i2se.com>
References: <6d3e9733-bebc-4347-95db-2a1c9018948d@i2se.com>
Message-ID: <13787b59-6bfc-d020-9853-ae37074009dc@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 01.02.2017 um 14:30 schrieb Stefan Wahren:
> Hi,
>
>> On Mon, Jan 30, 2017 at 4:54 PM, Russell King - ARM Linux
>> <linux@xxxxxxxxxxxxxxx> wrote:
>>
>>> /We need this regression fixed before 4.10 comes out so systems don't/
>>> /break when 4.10 comes out./
>> It will be fixed in the next rc with the following commit:
>>
> https://git.kernel.org/cgit/linux/kernel/git/shawnguo/linux.git/commit/?h=imx/fixes&id=a971c5545c3d45a1e33fda6e57913bb75aaa20c9
> <https://git.kernel.org/cgit/linux/kernel/git/shawnguo/linux.git/commit/?h=imx/fixes&id=a971c5545c3d45a1e33fda6e57913bb75aaa20c9>
>
>
> i want to report that the combination i.MX28 + imx-bootlets (requires
> CONFIG_ARM_APPENDED_DTB since bootlets can't handle DTBs) was also
> affected before and fixed by this patch.
>
> Btw are Arnd and Olof informed about this urgent patch?

@Shawn

Okay, 4.10-rc7 is out but this fix isn't applied :-(

Is there a chance for 4.10 or do we have to wait for 4.10.1?

Maybe the subject of the patch is to harmless.
