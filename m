From: akpm@linux-foundation.org (Andrew Morton)
Date: Tue, 31 Mar 2015 15:01:03 -0700
Subject: [PATCH v2 2/3] rtc: mediatek: Add MT6397 RTC driver
In-Reply-To: <1427703350.26464.15.camel@mtksdaap41>
References: <1426657537-41414-1-git-send-email-eddie.huang@mediatek.com>
 <1426657537-41414-3-git-send-email-eddie.huang@mediatek.com>
 <CAKdAkRSRXZ=1T+2Mfvjc4DsCCt1rxqGZpEuOUkU5KfPD2__BnQ@mail.gmail.com>
 <1427703350.26464.15.camel@mtksdaap41>
Message-ID: <20150331150103.c586821d4fddede12551c9ef@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 30 Mar 2015 16:15:50 +0800 Eddie Huang <eddie.huang@mediatek.com> wrote:

> > > +out_rtc:
> > > +       rtc_device_unregister(rtc->rtc_dev);
> > 
> > This is wrong. Whenever you jump to this label the RTC device has not
> > been registered yet.
> 
> Oops, will fix in next round.

Please ensure that Uwe's review comments (starting at
https://lkml.org/lkml/2015/3/17/494) have been addressed.
