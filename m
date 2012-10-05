From: rnayak@ti.com (Rajendra Nayak)
Date: Fri, 5 Oct 2012 19:01:58 +0530
Subject: OMAP4 clock/pm fixes [was: [PATCH v4 2/3] ARM: omap: hwmod: get
 rid of all omap_clk_get_by_name usage
In-Reply-To: <506EDEB3.3050003@ti.com>
References: <1346230576-20004-1-git-send-email-rnayak@ti.com>
 <1346230576-20004-3-git-send-email-rnayak@ti.com>
 <CAJOA=zM2sFsrdohooKp1+zsV_AK6dKnoN37+Gs2oskBUK4J00w@mail.gmail.com>
 <503F26A4.3050902@ti.com> <503F5517.4010100@ti.com>
 <1346344933.2327.43.camel@deskari> <5040586D.2020406@ti.com>
 <1346397309.18766.5.camel@lappyti> <504073CF.6010804@ti.com>
 <1346401643.32389.4.camel@deskari> <504075A0.7010708@ti.com>
 <506EAC89.2070307@ti.com> <506ED079.70700@ti.com> <506ED29E.7070403@ti.com>
 <506ED492.5010709@ti.com> <506EDEB3.3050003@ti.com>
Message-ID: <506EE14E.4080500@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> If the clkdm is in HW_AUTO, I can get DSS in sleep(STBYST and IDLEST all
> set). Is this helpful? Can we just leave modulemode on all the time?
> That'll be the best :)

Is everything around DSS enabled by default in omap2plus? If so, I
haven't seen Tero (who has been working on getting OMAP4 to sleep)
complain about DSS causing him any trouble. So you should be good
with whats already there atleast from 'not-gating-sleep' point of
view.
