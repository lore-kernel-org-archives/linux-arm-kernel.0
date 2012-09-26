From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Wed, 26 Sep 2012 15:23:44 +0300
Subject: [PATCHv7 17/21] ARM: OMAP4: TWL: enable high speed mode for PMIC
 communication
In-Reply-To: <1348661188.1956.1.camel@sokoban>
References: <1348590833-12335-1-git-send-email-t-kristo@ti.com>
 <1348590833-12335-18-git-send-email-t-kristo@ti.com>
 <5062E95C.6050903@ti.com> <1348661188.1956.1.camel@sokoban>
Message-ID: <5062F3D0.6040300@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/26/2012 03:06 PM, Tero Kristo wrote:
> On Wed, 2012-09-26 at 14:39 +0300, Peter Ujfalusi wrote:
>> Hi Tero,
>>
>> On 09/25/2012 07:33 PM, Tero Kristo wrote:
>>> With the new parameters, I2C can now be put to high speed mode for
>>> better performance.
>>
>> We have twl6040 on the same bus. have you tried this with audio enabled?
>> twl6040 is in standard mode (up to 100 kbps) after power up...
> 
> No, I don't have capability to try out audio. Can you give it a shot and
> see what happens? Otherwise we probably just have to drop this patch out
> for now.

Just compiled your mainline-3.6-rc5-omap-auto-ret-v7 branch with audio.
Works fine on my Blaze.

-- 
P?ter
