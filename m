From: olof@lixom.net (Olof Johansson)
Date: Tue, 31 Jul 2018 19:07:01 -0700
Subject: [GIT PULL] ARM: mvebu: dt64 for v4.19 (#2)
In-Reply-To: <87h8kfda2i.fsf@bootlin.com>
References: <87sh4e8eym.fsf@bootlin.com>
 <20180721213352.eborr5dctfk3t7j3@localhost>
 <87h8kfda2i.fsf@bootlin.com>
Message-ID: <CAOesGMgr0SH6VMkNHg9+C15QhYgus5+TpfgiTCHrLJbN2x8MhQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 31, 2018 at 2:32 AM, Gregory CLEMENT
<gregory.clement@bootlin.com> wrote:
> Hi Olof,
>
>  On sam., juil. 21 2018, Olof Johansson <olof@lixom.net> wrote:
>
>> On Fri, Jul 20, 2018 at 10:54:25AM +0200, Gregory CLEMENT wrote:
>>> Hi,
>>>
>>> Here is the second pull request for dt64 for mvebu for v4.19.
>>>
>>> Gregory
>>>
>>> The following changes since commit 4436a3711e3249840e0679e92d3c951bcaf25515:
>>>
>>>   arm64: dts: marvell: armada-37xx: reserve memory for ATF (2018-06-29 16:39:03 +0200)
>>>
>>> are available in the Git repository at:
>>>
>>>   git://git.infradead.org/linux-mvebu.git tags/mvebu-dt64-4.19-2
>>>
>>> for you to fetch changes up to c462f6c77e72804b72e008a91c4b6fa8d9b4b265:
>>>
>>>   arm64: dts: marvell: armada-37xx: update the crypto engine compatible (2018-07-13 13:42:03 +0200)
>>>
>>> ----------------------------------------------------------------
>>> mvebu dt64 for 4.19 (part 2)
>>>
>>> Use more specific compatible for the Inside Secure SafeXcel on the
>>> Armada 37xx and the Armada 7K/8K SoCs.
>>
>> I'll reply to the patches -- usually compatible should go from specific to
>> generic and you're replacing here instead of adding a more specific first. You
>> probably want to do the former instead.
>>
>> Not merged, let's settle discussion on the patch first.
>
> Now that Antoine explained the reason for replacing the compatible, will
> you pull the branch?

Yeah, seems reasonable. Merged!


-Olof
