From: tglx@linutronix.de (Thomas Gleixner)
Date: Tue, 11 Nov 2014 12:35:49 +0100 (CET)
Subject: [PATCH v5 0/6] ARM: mediatek: Add support for interrupt polarity
In-Reply-To: <20141109053820.GU3698@titan.lakedaemon.net>
References: <1414576824-16143-1-git-send-email-yingjoe.chen@mediatek.com>
 <20141109053820.GU3698@titan.lakedaemon.net>
Message-ID: <alpine.DEB.2.11.1411111234220.3935@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 9 Nov 2014, Jason Cooper wrote:

> Thomas, Marc,
> 
> Could I get Acks for the core changes and gic changes when you have
> a moment?

this depends on the core irqdomain changes which are not yet in
tip. I'm waiting for Jiangs latest iteration and Marcs feedback on
those.

Thanks,

	tglx
