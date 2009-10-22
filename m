From: daniel@caiaq.de (Daniel Mack)
Date: Thu, 22 Oct 2009 08:18:46 +0200
Subject: [PATCH] ARM: NX3: do not reference mxc_iomux_v3_init() for
	!CONFIG_ARCH_MX35
In-Reply-To: <316243.78392.qm@web51008.mail.re2.yahoo.com>
References: <1256149783-16789-1-git-send-email-daniel@caiaq.de>
	<316243.78392.qm@web51008.mail.re2.yahoo.com>
Message-ID: <20091022061846.GP14091@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 21, 2009 at 03:40:15PM -0700, Fabio Estevam wrote:
> > From: Daniel Mack <daniel@caiaq.de>
> > Subject: [PATCH] ARM: NX3: do not reference mxc_iomux_v3_init() for !\
> 
> There is a typo on the Subject: NX3 should be MX3.

Indeed. Thanks!

Daniel
