From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 15 Aug 2011 16:43:10 +0800
Subject: [PATCH V4 0/3] ARM: mmp: add audio sram support
In-Reply-To: <1313377893.14434.5.camel@Lily>
References: <1313377794-26721-1-git-send-email-leoy@marvell.com>
	<1313377893.14434.5.camel@Lily>
Message-ID: <CAMPhdO8rkct4H74zXBzaDa183u5vrPArerXgiNXwvQWzZT67Ng@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 15, 2011 at 11:11 AM, Haojian Zhuang
<haojian.zhuang@marvell.com> wrote:
> On Sun, 2011-08-14 at 20:09 -0700, Leo Yan wrote:
>> On mmp platform, there have two sram banks:
>> audio sram bank, and internal sram bank for video and PM.
>> So add the sram module to manage these sram banks.
>>
>> And register the sram banks so can dynamically alloc/free
>> the buffer.
>>
>> Leo Yan (3):
>> ? ARM: mmp: add sram allocator
>> ? ARM: mmp: register audio sram bank
>> ? ARM: mmp: register internal sram bank
>>
>> ?arch/arm/Kconfig ? ? ? ? ? ? ? ? ? ? ?| ? ?1 +
>> ?arch/arm/mach-mmp/Makefile ? ? ? ? ? ?| ? ?2 +-
>> ?arch/arm/mach-mmp/brownstone.c ? ? ? ?| ? 11 ++
>> ?arch/arm/mach-mmp/include/mach/mmp2.h | ? 13 +++
>> ?arch/arm/mach-mmp/include/mach/sram.h | ? 35 +++++++
>> ?arch/arm/mach-mmp/mmp2.c ? ? ? ? ? ? ?| ? ?3 +
>> ?arch/arm/mach-mmp/sram.c ? ? ? ? ? ? ?| ?168 +++++++++++++++++++++++++++++++++
>> ?7 files changed, 232 insertions(+), 1 deletions(-)
>> ?create mode 100644 arch/arm/mach-mmp/include/mach/sram.h
>> ?create mode 100644 arch/arm/mach-mmp/sram.c
>>
> Acked-by: Haojian Zhuang <haojian.zhuang@gmail.com>

Looks good to me. Thanks Haojian. Applied to -devel.
