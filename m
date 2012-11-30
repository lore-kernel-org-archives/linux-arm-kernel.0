From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 30 Nov 2012 15:38:56 +0000 (UTC)
Subject: [PATCH v5 00/12] Support for AM33xx PWM Subsystem
In-Reply-To: <518397C60809E147AF5323E0420B992E3EA0E480@DBDE01.ent.ti.com>
References: <1354006097-25895-1-git-send-email-avinashphilip@ti.com>
 <20121128142101.GB21042@avionic-0098.adnet.avionic-design.de>
 <518397C60809E147AF5323E0420B992E3EA0E480@DBDE01.ent.ti.com>
Message-ID: <alpine.DEB.2.00.1211301533560.18138@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 30 Nov 2012, Philip, Avinash wrote:

> Is there any way to get HWMOD and DT patches getting accepted in 3.8?
> Or should I wait and send rebased patch based on 3.8-rc1?

Our upstreams aren't taking any more new features for v3.8, so basing on 
v3.8-rc1 is the best thing to do now.

In the meantime, you can try basing your series against a recent for-next 
HEAD to get an early start on testing, etc.


- Paul
