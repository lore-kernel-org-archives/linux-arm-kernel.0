From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Fri, 12 Jul 2013 10:59:41 +0200
Subject: [PATCH] ARM: OMAP2+: twl-common: Remove code for twl6030 and
 twl6040 setup for legacy boot
In-Reply-To: <20130711163503.GA6611@kahuna>
References: <1373552638-13930-1-git-send-email-peter.ujfalusi@ti.com>
 <20130711145916.GA6138@kahuna> <51DED333.9080609@ti.com>
 <20130711163503.GA6611@kahuna>
Message-ID: <51DFC57D.2020905@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/11/2013 06:35 PM, Nishanth Menon wrote:
> right - now that we removed the set_voltage/get_voltage custom code,
> there are no longer any way the code introduced in the commit can be
> exercised.

If we boot with DT (which is the case with OMAP4/5) this part was not even
executed, so the custom callbacks were not added from here for OMAP4. I might
be wrong here...

-- 
P?ter
