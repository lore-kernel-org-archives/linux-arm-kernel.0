From: Jason@zx2c4.com (Jason A. Donenfeld)
Date: Tue, 30 May 2017 14:20:36 +0200
Subject: separate softirq/irq stack on arm
Message-ID: <CAHmME9r2C64ZZg6kEzZgAPwm56_LoohKjUcvC_sMrpqBZSHVNw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey folks,

I've been under the assumption that Linux on ARM had a separate stack
for IRQ/SoftIRQ processing. However, in trying to look for how this is
implemented, I've only found that ARM64 has a separate IRQ stack, but
ARM32 does not. Is this correct, that ARM32 does not use a separate
stack? In that case, is this something on the table to add at some
point, just as MIPS did recently?

Thanks,
Jason
