From: mark.yao@rock-chips.com (Mark yao)
Date: Tue, 05 Apr 2016 09:13:28 +0800
Subject: [RFC PATCH v1 0/4] Add Rockchip RGA support
In-Reply-To: <CACvgo53rYAW4H0SJnz8-7QtfRHmWWUh+7L7DiUbjBJ-hPBMHug@mail.gmail.com>
References: <1458552518-25527-1-git-send-email-ykk@rock-chips.com>	<1571169.Hy8an0n7lM@diego>	<CACvgo516ewfwGCpV=noX+re1x8t3Sp1t39Sha+A2-tQ5YsoihA@mail.gmail.com>	<17189219.y56YqHz6yR@diego>	<CACvgo50REvRxN2_qdw=2NeTTSgjpA+9c8OZgPE0q19meH6ArKA@mail.gmail.com>
 <CACvgo53rYAW4H0SJnz8-7QtfRHmWWUh+7L7DiUbjBJ-hPBMHug@mail.gmail.com>
Message-ID: <57031138.7020408@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016?03?31? 04:03, Emil Velikov wrote:
> On 29 March 2016 at 14:13, Emil Velikov <emil.l.velikov@gmail.com> wrote:
>> On 28 March 2016 at 23:13, Heiko St?bner <heiko@sntech.de> wrote:
>>
>>> I have the feeling we're going quite a bit off-topic right now :-) .
>>> The binary-driver-crazyness, hasn't really anything to do with Yakir's support
>>> for the RGA (which is about raster-graphics-acceleration, so 2d stuff).
>>>
>>> And me mentioning the armsoc-ddx was merely a means to allow some sort of
>>> different userspace user, as requested in your original mail ;-) .
>>>
>> Seems like I forgot to state the obvious - for all the reasons
>> mentioned, the armsoc ddx seems like a bad example.
>>
>>> Maybe you know a better use-case on where to demonstrate the viability of the
>>> userspace API for it as originally requested.
>> I'm afraid that my RockChip-foo is extremely limited. Perhaps the
>> actual user of these should be mentioned ? xf86-video-rockhip (is
>> there one ?) or any other effort/project that lacks some (all?) of the
>> criticism listed.
>>
>> (Sort of) the bottom line - either reuse the existing interfaces or
>> provide an approved, full blown userspace (libdrm demos/programs do
>> not count) that uses the new interfaces.
>>
>> I haven't made these rules, just a fool^Wguy that repeats them so that
>> people don't abuse them much. If in doubt check with Dave and Daniel V
>> - they had enough repeating these.
>>
> I can see how my earlier response may have been come
> across/interpreted as aggressive and/or demanding. Apologies anyone
> got upset/annoyed.
>
> Let me try in another light - if you guys are willing to have
> xf86-video-rockchip or keep track of/co-maintain armsoc, pretty much
> everyone will be over the moon. Personally I'd opt for the former,
> taking the modesetting (the one in the xserver tree) as a base - it
> has all the cool new bits ;-)
>
> Regards,
> Emil
>
>
>

I'd like to use modesetting more than armsoc. the modesetting seems more 
stable and it support glamor(2d acceleration with gpu).

We have some work on modesetting ddx, with some hack, both 3d dri2 and 
glamor 2d acceleration can works with mali gpu.

So if Yakir want to support EXA on ddx, I hope he can use modesetting.


Thanks.

-- 
?ark Yao
