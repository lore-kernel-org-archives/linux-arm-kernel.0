From: hrhaan@gmail.com (Harro Haan)
Date: Thu, 12 Dec 2013 23:12:13 +0100
Subject: [PATCH 1/7] PCI: imx6: Make reset-gpio optional
In-Reply-To: <CAErSpo7C4rJZBuBUDRN6L_fkQZNthfeY=_oJ=_WCcqAxoj2Xig@mail.gmail.com>
References: <1386757818-5154-1-git-send-email-marex@denx.de>
 <201312121122.33746.marex@denx.de>
 <CAJ+vNU0aoOtZEdq6GDPpwZAgu+EN3FjHnr8JAdXCxOiDfJ5m6A@mail.gmail.com>
 <201312121925.27591.marex@denx.de>
 <CAErSpo7C4rJZBuBUDRN6L_fkQZNthfeY=_oJ=_WCcqAxoj2Xig@mail.gmail.com>
Message-ID: <CAB5oZtBUTnA3FdO9_YyORfUx7Joqy96NF55o1-XQkFPXsWLoig@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12 December 2013 22:07, Bjorn Helgaas <bhelgaas@google.com> wrote:
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

Yes, Marek resolved the build warning comment in [PATCH V2 3/7]. Regards, Harro
