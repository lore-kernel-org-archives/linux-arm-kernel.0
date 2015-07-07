From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 7 Jul 2015 13:52:46 +0100
Subject: [RESEND 00/10] regulator: pwm-regulator: Introduce continuous-mode
In-Reply-To: <20150707120332.GC2887@sirena.org.uk>
References: <1436173112-21397-1-git-send-email-lee.jones@linaro.org>
 <20150706204812.GD11162@sirena.org.uk> <20150707065250.GF3182@x1>
 <20150707120332.GC2887@sirena.org.uk>
Message-ID: <20150707125246.GD3182@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 07 Jul 2015, Mark Brown wrote:
> On Tue, Jul 07, 2015 at 07:52:50AM +0100, Lee Jones wrote:
> > On Mon, 06 Jul 2015, Mark Brown wrote:
> > > On Mon, Jul 06, 2015 at 09:58:22AM +0100, Lee Jones wrote:
> 
> > > > This patch-set has been rebased on to v4.2-rc1.
> 
> > > Is this just a rebase or has the code been changed as well - IIRC there
> > > were some bits in there that weren't supposed to be be there?
> 
> > This is a rebased resend with those couple of lines of debug removed.
> 
> OK, so not actually a resend then :(

The changes are very trivial.  Literally just 4 debug prints removed.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
