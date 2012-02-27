From: rlove@google.com (Robert Love)
Date: Mon, 27 Feb 2012 12:18:09 -0500
Subject: elf_set_personality()
In-Reply-To: <20120227171634.GC2440@n2100.arm.linux.org.uk>
References: <20120227123612.GD12917@tbergstrom-lnx.Nvidia.com>
 <20120227130453.GV22562@n2100.arm.linux.org.uk>
 <20120227150300.GF12917@tbergstrom-lnx.Nvidia.com>
 <CAG6tG3y6+B8Si8bUFLK5aGmG2sed6y39V7XMcKZNDJuUbWCCjQ@mail.gmail.com>
 <20120227164130.GB2440@n2100.arm.linux.org.uk>
 <CAG6tG3zwfhZXw5M_kk4ry4H6NhTuKyenP-6UUm+XwyxbBbcG9g@mail.gmail.com>
 <20120227171634.GC2440@n2100.arm.linux.org.uk>
Message-ID: <CAG6tG3xu5RKRmdn+vEkhFjh3nT7N9MuHMowgJHgWGKX51RmS9A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 27, 2012 at 12:16 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
>> There is no reason to be different and I'd prefer to consolidate or at
>> least copy the code.
>>
>> It is unfortunate that each implementer of fops->mmap needs to
>> manually handle the READ_IMPLIES_EXEC case.
>
> That would mean ignoring PROT_EXEC entirely.

Right. I was agreeing with your first suggestion.

As goes vanilla mmap, so goes ashmem.

I no longer work on Android, but I can put together a patch.

      Robert
