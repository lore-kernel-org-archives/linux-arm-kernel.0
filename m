From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 8 Mar 2011 11:10:53 -0700 (MST)
Subject: [PATCH 3/3] OMAP2+: powerdomain: add pwrdm_can_ever_lose_context()
In-Reply-To: <AANLkTimuYVuxiqifxPEqfxyVuSYcKL563TZCP5uNM8Ss@mail.gmail.com>
References: <20110308021018.31946.29962.stgit@twilight.localdomain>
	<20110308021551.31946.19903.stgit@twilight.localdomain>
	<AANLkTimuYVuxiqifxPEqfxyVuSYcKL563TZCP5uNM8Ss@mail.gmail.com>
Message-ID: <alpine.DEB.2.00.1103081108300.10981@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 8 Mar 2011, Varadarajan, Charulatha wrote:

> Do you really want to return 1 in case of invalid powerdomain pointer?

Sure, that's why I wrote it that way.  It seems less risky than returning 
0.  Do you have a proposal that makes more sense, given that this is going 
to be called immediately after a omap_{device,hwmod}_get_pwrdm() ?


- Paul
