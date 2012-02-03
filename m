From: notasas@gmail.com (Grazvydas Ignotas)
Date: Fri, 3 Feb 2012 13:42:13 +0200
Subject: patch "tty: serial: OMAP: ensure FIFO levels are set correctly in
 non-DMA" added to tty tree
In-Reply-To: <20120203205401.5ddf241d@notabene.brown>
References: <13274430881471@kroah.org>
 <alpine.DEB.2.00.1201251156361.5324@utopia.booyaka.com>
 <20120126042155.GA3185@suse.de>
 <alpine.DEB.2.00.1201252124470.11174@utopia.booyaka.com>
 <20120126191604.GA15516@suse.de>
 <alpine.DEB.2.00.1201261225520.32667@utopia.booyaka.com>
 <alpine.DEB.2.00.1202021302070.586@utopia.booyaka.com>
 <20120203150708.386951d2@notabene.brown>
 <alpine.DEB.2.00.1202022137150.586@utopia.booyaka.com>
 <20120203205401.5ddf241d@notabene.brown>
Message-ID: <CANOLnONsZKHJPbEx2+ic3EZ1PqcD30VT4Z2bR5iW-JNQJQL0GA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 3, 2012 at 11:54 AM, NeilBrown <neilb@suse.de> wrote:
> On Thu, 2 Feb 2012 22:45:53 -0700 (MST) Paul Walmsley <paul@pwsan.com> wrote:
>> On Fri, 3 Feb 2012, NeilBrown wrote:
>>
>> > then CPUIDLE enters lower states and I think it uses less power but I
>> > sometimes lose the first char I type (that is known) but also I sometimes get
>> > corruption on output.
>>
>> I don't see any output corruption on 35xx BeagleBoard, either with or
>> without these patches. ?So this is presumably a 37xx-centric problem, and
>> unrelated to these patches, I would guess.
>
> Maybe it is 37xx specific. ?I think this is a DM3730.

Not sure if it's the same problem but with 3530 on 3.2 with
sleep_timeout set, I usually get first char dropped (as expected) but
sometimes I get corrupted char instead too. Corrupt char seems to
almost always happen if I set cpufreq to powersave, on performace it's
almost always ok, so maybe it's some timing problem,



-- 
Gra?vydas
