From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 29 Nov 2011 05:56:51 +0100
Subject: [V2 3/3] RTC: sa1100: support sa1100, pxa and mmp soc families
In-Reply-To: <87hb1o8a82.fsf@free.fr>
References: <1322447732-23320-1-git-send-email-jtzhou@marvell.com>
 <1322447732-23320-2-git-send-email-jtzhou@marvell.com>
 <CAN1soZz7ooHU-TxuZHGrjmQ509H30YaieRc-ccq3pbi=SvvA7Q@mail.gmail.com>
 <87hb1o8a82.fsf@free.fr>
Message-ID: <20111129045651.GR15008@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17:47 Mon 28 Nov     , Robert Jarzmik wrote:
> Haojian Zhuang <haojian.zhuang@gmail.com> writes:
> 
> > On Mon, Nov 28, 2011 at 10:35 AM, Jett.Zhou <jtzhou@marvell.com> wrote:
> >> Since the regmap of rtc on sa1100, pxa and mmp Marvell soc families are
> >> almost the same, so re-arch the rtc-sa1100 to support them.
> >>
> >> Signed-off-by: Jett.Zhou <jtzhou@marvell.com>
> >> ---
> >> ?arch/arm/mach-pxa/devices.c ? ?| ? 20 +++
> >> ?arch/arm/mach-sa1100/generic.c | ? 20 +++
> >> ?drivers/rtc/Kconfig ? ? ? ? ? ?| ? ?2 +-
> >> ?drivers/rtc/rtc-sa1100.c ? ? ? | ?273 ++++++++++++++++++++++++++++------------
> >> ?4 files changed, 236 insertions(+), 79 deletions(-)
> >>
> > Acked-by: Haojian Zhuang <haojian.zhuang@gmail.com>
> Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>
please update as commented onthe other e-mail

Best Regards,
J.
