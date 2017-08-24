From: eric@anholt.net (Eric Anholt)
Date: Thu, 24 Aug 2017 11:38:51 -0700
Subject: [PATCH] ARM: bcm283x: Fix SMP for old dtb files
In-Reply-To: <CAK8P3a303oEejUZQ3bXVdTLwsWCC2BiLqzigCYbw6T0tAF=Y+g@mail.gmail.com>
References: <1503515314-16576-1-git-send-email-stefan.wahren@i2se.com>
 <CAK8P3a303oEejUZQ3bXVdTLwsWCC2BiLqzigCYbw6T0tAF=Y+g@mail.gmail.com>
Message-ID: <87pobkak04.fsf@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> On Wed, Aug 23, 2017 at 9:08 PM, Stefan Wahren <stefan.wahren@i2se.com> wrote:
>> Since "irqchip: bcm2836: Move SMP startup code to arch/arm" the SMP
>> for BCM2836 and BCM2837 (32 bit) depends on commit "ARM: dts: bcm283x:
>> Add 32-bit enable method for SMP". This patch fixes SMP for older
>> dtb files.
>>
>> Reported-by: Arnd Bergmann <arnd@arndb.de>
>> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
>
> Looks good to me, thanks for the update.
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Great!  I've squashed this into the original commit, tested, and I'll
generate a new PR without the DT merge.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170824/b7c39bda/attachment.sig>
