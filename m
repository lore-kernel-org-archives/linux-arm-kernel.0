From: jeremy.kerr@canonical.com (Jeremy Kerr)
Date: Fri, 11 Jun 2010 17:18:44 +0800
Subject: [RFC,PATCH 1/2] Add a common struct clk
In-Reply-To: <19473.61547.684572.647641@ipc1.ka-ro>
References: <1275636608.606606.450179637764.0.gpush@pororo>
	<201006111557.12249.jeremy.kerr@canonical.com>
	<19473.61547.684572.647641@ipc1.ka-ro>
Message-ID: <201006111718.47426.jeremy.kerr@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lothar,

> Using a mutex in clk_enable()/clk_disable() is a bad idea, since that
> makes it impossible to call those functions in interrupt context.

Do we do this at the moment? I know at least one implementation of clk_enable 
uses a mutex for locking.

Cheers,


Jeremy
