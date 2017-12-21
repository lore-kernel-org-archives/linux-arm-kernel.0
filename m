From: tony@atomide.com (Tony Lindgren)
Date: Thu, 21 Dec 2017 07:15:36 -0800
Subject: [PATCH 1/8] ARM: dts: dra7: Add vbb-supply to cpu and additional
 voltages
In-Reply-To: <1513697066-27732-2-git-send-email-d-gerlach@ti.com>
References: <1513697066-27732-1-git-send-email-d-gerlach@ti.com>
 <1513697066-27732-2-git-send-email-d-gerlach@ti.com>
Message-ID: <20171221151536.GR3875@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Dave Gerlach <d-gerlach@ti.com> [171219 15:27]:
> Add a vbb-supply phandle to the cpus node and also add an additional
> triplet of voltages for each OPP in the operating-points-v2 table to
> make use of the multi regulator support in the OPP core and provide the
> vbb regulator for use by the ti-opp-supply driver.

Sounds like these depend on the ti-opp-supply being available first?

Regards,

Tony
