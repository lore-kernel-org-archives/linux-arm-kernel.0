From: sebastian.capella@linaro.org (Sebastian Capella)
Date: Tue, 25 Feb 2014 15:24:09 -0800
Subject: [PATCH RFC v1 1/3] ARM: Add irq disabled version of soft_restart.
In-Reply-To: <530CCFB5.5030205@ti.com>
References: <1392774729-3235-1-git-send-email-sebastian.capella@linaro.org>
 <1392774729-3235-2-git-send-email-sebastian.capella@linaro.org>
 <20140222102616.GG21483@n2100.arm.linux.org.uk>
 <20140224231345.10580.62916@capellas-linux> <530C4CAE.5000202@ti.com>
 <alpine.DEB.2.02.1402251125500.21251@ionos.tec.linutronix.de>
 <530CCFB5.5030205@ti.com>
Message-ID: <20140225232409.18229.4284@capellas-linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Russ Dill (2014-02-25 09:15:33)
> On 02/25/2014 02:27 AM, Thomas Gleixner wrote:
> > If you want escape the tracer and in that case you really want it 
> > being on a different stack, use raw_local_irq_* which are not
> > traced.
> 
> So it might make sense to change soft_restart to use the
> raw_local_irq_* calls.

I've added this change.  So far it's working well.

Thanks!

Sebastian
