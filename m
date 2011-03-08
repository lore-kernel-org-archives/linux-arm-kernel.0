From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 8 Mar 2011 13:54:59 -0700 (MST)
Subject: [PATCH 1/1] omap3: Save and restore CM_AUTOIDLE_PLL across off
	mode
In-Reply-To: <c9be31ca3dab99320a409e957330506c@mail.gmail.com>
References: <1297353724-11665-1-git-send-email-premi@ti.com>
	<1297353724-11665-2-git-send-email-premi@ti.com>
	<alpine.DEB.2.00.1103041540540.10981@utopia.booyaka.com>
	<B85A65D85D7EB246BE421B3FB0FBB593024C0E5A55@dbde02.ent.ti.com>
	<c9be31ca3dab99320a409e957330506c@mail.gmail.com>
Message-ID: <alpine.DEB.2.00.1103081354090.10981@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sanjeev,

On Mon, 7 Mar 2011, Vishwanath Sripathy wrote:

> As per OMAP3630 TRM Section 26.5, register CM_AUTOIDLE_PLL is supposed to
> be restored by ROM code. The PM code should only store these registers
> before entering off mode. So only thing that needs to be done in this
> patch set is to save these registers.

If you agree with Vishwa's suggestion, could you please test it and see 
whether it is sufficient?


- Paul
