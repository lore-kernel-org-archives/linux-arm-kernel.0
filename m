From: t-kristo@ti.com (Tero Kristo)
Date: Fri, 29 Nov 2013 20:59:07 +0200
Subject: [PATCHv10 00/41] ARM: TI SoC clock DT conversion
In-Reply-To: <20131129171256.GN31534@atomide.com>
References: <1385453182-24421-1-git-send-email-t-kristo@ti.com>
 <52969313.6090207@ti.com>
 <alpine.DEB.2.02.1311281857100.23429@utopia.booyaka.com>
 <20131129171256.GN31534@atomide.com>
Message-ID: <5298E3FB.4010908@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/29/2013 07:12 PM, Tony Lindgren wrote:
> * Paul Walmsley <paul@pwsan.com> [131128 10:59]:
>> On Wed, 27 Nov 2013, Nishanth Menon wrote:
>>
>>> http://pastebin.mozilla.org/3681900 -> AM3517-evm (not sure yet how
>>> long this has been broken).
>>
>> Seems to work in v3.13-rc1:
>>
>> http://www.pwsan.com/omap/testlogs/test_v3.13-rc1/20131124230250/boot/3517evm/3517evm_log.txt
>
> FYI, not really related to the clock patches, but we're also missing the .dtsi
> file for 3517 currently for the device tree based booting. I'm planning to take
> a look at that next week.

Yea I would guess this prevents this set from working also on that board. :)

-Tero
