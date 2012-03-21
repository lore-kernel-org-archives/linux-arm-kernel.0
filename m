From: nsekhar@ti.com (Nori, Sekhar)
Date: Wed, 21 Mar 2012 15:37:57 +0000
Subject: [PATCH v8 4/8] ARM: davinci: Consolidate time keeping and irq
 enable
In-Reply-To: <CAP245DW9SdTYNc8XXwiuHzo5Y-aZrLc2qP0MekKkyAT2TosjbQ@mail.gmail.com>
References: <1332274969-15782-1-git-send-email-rob.lee@linaro.org>
 <1332274969-15782-5-git-send-email-rob.lee@linaro.org>
 <CAMXH7KH5kS=wPFdC8QrtnhE6_sZqmsJ8h=6Gs3kfHOTbeHjacA@mail.gmail.com>
 <CAP245DW9SdTYNc8XXwiuHzo5Y-aZrLc2qP0MekKkyAT2TosjbQ@mail.gmail.com>
Message-ID: <DF0F476B391FA8409C78302C7BA518B631800A29@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Amit,

On Wed, Mar 21, 2012 at 20:06:29, Amit Kucheria wrote:
> Rob, you should start a new '3.4-fixes' branch containing such
> bugfixes that can be pushed to Len after -rc1.

I think it is OK to send the fixes to Len right away so
he can queue the fixes during merge window if he gets the
chance. That way we may get a non-broken -rc1.

Thanks,
Sekhar
