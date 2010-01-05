From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 5 Jan 2010 16:07:05 -0700 (MST)
Subject: [PATCH] ARM: OMAP4 clock framework: Remove the checks preventing
	OMAP4 clockdomain validation
In-Reply-To: <1262189386-22239-1-git-send-email-abhijitpagare@ti.com>
References: <1262189386-22239-1-git-send-email-abhijitpagare@ti.com>
Message-ID: <alpine.DEB.2.00.1001051606500.21295@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 30 Dec 2009, Abhijit Pagare wrote:

> The clockdomain related code being in place, it is not necessary to have
> some part of the clock code commented out. This would help the validation of
> the clockdomain functions using the clock level interfaces.
> 
> Signed-off-by: Abhijit Pagare <abhijitpagare@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>

Thanks, queued for 2.6.34.


- Paul
