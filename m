From: bhelgaas@google.com (Bjorn Helgaas)
Date: Thu, 12 Dec 2013 14:20:30 -0700
Subject: [PATCH 1/7] PCI: imx6: Make reset-gpio optional
In-Reply-To: <CAErSpo7C4rJZBuBUDRN6L_fkQZNthfeY=_oJ=_WCcqAxoj2Xig@mail.gmail.com>
References: <1386757818-5154-1-git-send-email-marex@denx.de>
 <201312121122.33746.marex@denx.de>
 <CAJ+vNU0aoOtZEdq6GDPpwZAgu+EN3FjHnr8JAdXCxOiDfJ5m6A@mail.gmail.com>
 <201312121925.27591.marex@denx.de>
 <CAErSpo7C4rJZBuBUDRN6L_fkQZNthfeY=_oJ=_WCcqAxoj2Xig@mail.gmail.com>
Message-ID: <CAErSpo682q3TkjsZvtR4Qhvvwfmx7FUB2QZTfQV+3Q+nK0C-7w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 12, 2013 at 2:07 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Thu, Dec 12, 2013 at 11:25 AM, Marek Vasut <marex@denx.de> wrote:
>> Bjorn, would you mind picking 2/7...6/7 of this series so we are done with
>> those? I will re-post 1/7 as a self-standing patch afterwards, it has no impact
>> on the rest of the series.
>
> Sure.  I can't really evaluate these myself, so I'm looking for acks
> from Richard or Shawn.
>
> I noticed Pratyush, Tim, and Harro had some questions the first time
> around, and I don't know whether they got resolved.

By the way, I tried to apply patches 2-6 to my pci/host-imx6 branch,
but patch 6 ("PCI: imx6: Fix bugs in PCIe startup code") didn't apply
cleanly.

I pushed the branch to
http://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/log/?h=pci/host-imx6
if you want to try it yourself.

Bjorn
