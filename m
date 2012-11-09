From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 9 Nov 2012 09:05:12 +0100
Subject: [PATCH 1/2] arm: bcm2835: move to the multiplatform support
In-Reply-To: <509C7270.9000508@wwwdotorg.org>
References: <1351419853-25146-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <509C7270.9000508@wwwdotorg.org>
Message-ID: <20121109090512.136a9954@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen,

On Thu, 08 Nov 2012 20:03:12 -0700, Stephen Warren wrote:

> Thomas, just a heads up - the VFP commit you mention above should show
> up in v3.7-rc5 which I imagine will be released this weekend, and the
> debug_ll_io_init feature I mentioned in another response is already
> available is arm-soc branch devel/debug_ll_init. If you rebase this
> patch on a merge of those two branches, it should be in good shape for
> me to apply it.

Excellent, thanks for the heads up! As I've said in another e-mail, I
was at ELCE this week, which obviously means I wasn't able to do any
sort of kernel development. I'm back now, and planning to work on this
and the irqchip things.

Thanks,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
