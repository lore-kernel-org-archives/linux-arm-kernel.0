From: arno@natisbad.org (Arnaud Ebalard)
Date: Fri, 22 Nov 2013 16:29:19 +0100
Subject: [PATCH 0/2] ARM: mvebu: fix DT def. of PCIe units for mv78230 and
 mv78260
In-Reply-To: <20131122150455.GH29241@titan.lakedaemon.net> (Jason Cooper's
 message of "Fri, 22 Nov 2013 10:04:55 -0500")
References: <cover.1383681717.git.arno@natisbad.org>
 <20131122150455.GH29241@titan.lakedaemon.net>
Message-ID: <878uwge9ps.fsf@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Jason Cooper <jason@lakedaemon.net> writes:

> On Tue, Nov 05, 2013 at 09:45:33PM +0100, Arnaud Ebalard wrote:
>> Second patch fixes mv78260 .dtsi to reflect the fact that the two first
>> units are x4 and quad x1 capable, and third (and last) interface is x4
>> only. This patch has only been compiled and not tested on real hardware.
>> As associated changes are quite error-prone, I think it needs some
>> careful review.
>
> This, in addition to changing the .dtsi files is where my "let's take
> time merging this" came from.
>
> ...
>> Arnaud Ebalard (2):
>>   ARM: mvebu: second PCIe unit of Armada XP mv78230 is only x1 capable
>>   ARM: mvebu: fix second and third PCIe units of Armada XP mv78260
>> 
>>  arch/arm/boot/dts/armada-xp-mv78230.dtsi |  24 +++----
>>  arch/arm/boot/dts/armada-xp-mv78260.dtsi | 109 ++++++++++++++++++++++++-------
>>  2 files changed, 97 insertions(+), 36 deletions(-)
>
> At any rate, since these are going to -stable anyway, there's no need to
> rush it.  These are currently queued up as fixes for v3.13-rc1.

fine with me.

Cheers,

a+
