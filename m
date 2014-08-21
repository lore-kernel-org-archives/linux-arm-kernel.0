From: nm@ti.com (Nishanth Menon)
Date: Thu, 21 Aug 2014 12:09:38 -0500
Subject: [PATCH V2 2/2] Input: misc: introduce palmas-pwrbutton
In-Reply-To: <20140821170512.GA3796@core.coreip.homeip.net>
References: <1408392810-16011-1-git-send-email-nm@ti.com>
 <1408636935-29515-1-git-send-email-nm@ti.com>
 <1408636935-29515-3-git-send-email-nm@ti.com>
 <20140821170512.GA3796@core.coreip.homeip.net>
Message-ID: <CAGo_u6rTnNxRhgOVkUHscB79qWZz3gVWRrM50Cu9ozO8RDsvZg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 21, 2014 at 12:05 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
>
> You can not use free_irq with devm-managed resources. As I mentioned, since you
> need manual unwinding, I'd rather you not use managed resources in the driver
> at all.
ok. will drop all devm_  ops in the next version.

---
Regards,
Nishanth Menon
