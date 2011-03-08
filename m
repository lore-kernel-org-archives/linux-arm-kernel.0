From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 8 Mar 2011 12:21:43 -0700 (MST)
Subject: [PATCH 2/7] OMAP2+: mux: Enable wakeup for wakeup enable requested
	pads
In-Reply-To: <AANLkTiknEQrqUt1-sY6-aDw4R5ZMP2uErSjRNB5Yex_v@mail.gmail.com>
References: <1299064343-28534-1-git-send-email-govindraj.raja@ti.com>
	<87lj0u8mrf.fsf@ti.com> <87tyfi49cs.fsf@ti.com>
	<AANLkTiknEQrqUt1-sY6-aDw4R5ZMP2uErSjRNB5Yex_v@mail.gmail.com>
Message-ID: <alpine.DEB.2.00.1103081220140.10981@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


By the way, if your patch relies on OMAP_DEVICE_PAD_IDLE, you should 
probably sync up with Sricharan, who is apparently planning to remove that 
flag:

   http://www.mail-archive.com/linux-omap at vger.kernel.org/msg46296.html


- Paul
