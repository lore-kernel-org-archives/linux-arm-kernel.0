From: bhelgaas@google.com (Bjorn Helgaas)
Date: Thu, 29 May 2014 16:13:57 -0600
Subject: [GIT PULL] Generic PCI host controller driver for 3.16
In-Reply-To: <20140529082546.GH29812@arm.com>
References: <20140527224051.GA13786@arm.com>
 <20140528205956.GU11907@google.com>
 <20140529082546.GH29812@arm.com>
Message-ID: <CAErSpo4vNjSBTGhOdC8cZsMibjZ==B63kyrFK8zt_Fia9EJKzQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 29, 2014 at 2:25 AM, Will Deacon <will.deacon@arm.com> wrote:
> On Wed, May 28, 2014 at 09:59:56PM +0100, Bjorn Helgaas wrote:
>> On Tue, May 27, 2014 at 11:40:51PM +0100, Will Deacon wrote:
>> > Please can you pull my generic PCI host controller driver for 3.16?
>> >
>> > It's been doing the rounds on the lists for some time and things have
>> > settled down now, despite a recent failed attempt at factoring out the
>> > configuration space accessors.
>>
>> Is this the same as patches 2 & 3 of your v7 series of May 23?
>
> Yes, they're identical so you can just pick the two patches from there if
> you prefer.

Great, just wanted to make sure these had been on the list and that
you didn't need me to pick up patch 1 ("ARM: kconfig: allow PCI
support to be selected with ARCH_MULTIPLATFORM") or 4 ("PCI: Generic
Configuration Access Mechanism support").

I put this on my pci/host-generic branch for v3.16, thanks!

Bjorn
