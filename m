From: arno@natisbad.org (Arnaud Ebalard)
Date: Tue, 18 Nov 2014 19:30:28 +0100
Subject: [PATCHv3 00/12] arm: mvebu: add Synology DS213j and DS414 .dts
 files
In-Reply-To: <546B22E1.4020507@gmail.com> (Sebastian Hesselbarth's message of
 "Tue, 18 Nov 2014 11:43:45 +0100")
References: <cover.1416266432.git.arno@natisbad.org>
 <546B22E1.4020507@gmail.com>
Message-ID: <87zjbobbuj.fsf@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sebastian,

Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com> writes:

> On 11/18/2014 12:26 AM, Arnaud Ebalard wrote:
>> This series adds .dts files for Synology DS213j (armada 370 2-bay NAS) and
>> DS414 (armada XP 4-bay NAS) devices. It is based on comments received on
>> a v0 submission of DS213j .dts file [1] and Andrew's comments on a v1 (
>> for both DS213j and DS414 .dts files) [2] and Andrew/Sebastian' comments
>> on v2 regarding pinctrl improvements [3].
>>
>> Cheers,
>>
>> a+
>>
>> [1]: http://thread.gmane.org/gmane.linux.drivers.devicetree/95401
>> [2]: http://thread.gmane.org/gmane.linux.drivers.devicetree/98830
>> [3]: http://thread.gmane.org/gmane.linux.drivers.devicetree/98892
>>
>> Changes since v2:
>>
>> - Added various patches to improve/refactor Armada 370/XP pinctrl
>>    nodes/properties and use sensible defaults when possible.
>
> Arnaud,
>
> sorry I didn't remember earlier, but there has been a similar patch
> set that already deals with Armada-XP pinctrl and ethernet settings
> [1].
>
> [1]
> https://lkml.kernel.org/g/1411157684-6991-1-git-send-email-sebastian.hesselbarth at gmail.com
>
> It has already been merged by Jason into mvebu/dt for v3.19, so it
> seems you'll have to rebase your patches on top of it. AFAIKS, you
> can drop pinctrl node consolidation for the SoCs (XP at least) and
> RGMII consolidation. The other changes you did for common 370/XP
> dtsi, UART, and SPI are valuable and you should keep them.

I'll rebase the whole series and send a v4.

> If I find some time, I'll have a closer look at both patch sets.
> Sorry again for not remembering earlier!

no problem.

Cheers,

a+
