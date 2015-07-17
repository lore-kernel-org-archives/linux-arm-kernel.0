From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 17 Jul 2015 11:46:25 +0800
Subject: [PATCH] input: snvs_pwrkey: add linux prefix for wakeup property
In-Reply-To: <20150716183408.GD32571@dtor-ws>
References: <1436930409-6536-1-git-send-email-shawnguo@kernel.org>
 <CAHrpEqS2o6_B6dNrnWJ06ASWaB0SGxur1o3VuN2A-QywWhbWVA@mail.gmail.com>
 <20150716183408.GD32571@dtor-ws>
Message-ID: <20150717034625.GD12927@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 16, 2015 at 11:34:08AM -0700, Dmitry Torokhov wrote:
> I should have said to use "wakeup-source", not simply "wakeup" so that
> we'd match with I2C annotation.

Yeah, consistency is the real motivation of this patch.  I do not
like that different properties are invented for the same purpose.  As it
seems that subsystems are all moving to "wakeup-source", I would be
happy to get it consistent with that.  V2 will be coming soon.

Shawn
