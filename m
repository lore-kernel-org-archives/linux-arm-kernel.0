From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 10 Jun 2015 08:58:13 +0100
Subject: [PATCH 6/8] regulator: pwm-regulator: Separate voltage-table
 initialisation
In-Reply-To: <20150609171442.GL14071@sirena.org.uk>
References: <1433529771-24496-1-git-send-email-lee.jones@linaro.org>
 <1433529771-24496-7-git-send-email-lee.jones@linaro.org>
 <20150609171442.GL14071@sirena.org.uk>
Message-ID: <20150610075813.GA2982@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 09 Jun 2015, Mark Brown wrote:
> On Fri, Jun 05, 2015 at 07:42:49PM +0100, Lee Jones wrote:
> > Take this out of the main .probe() routine in order to facilitate the
> > introduction of different ways to obtain 'duty cycle' information.
> 
> This and the rest of the patches are fine but seem to depend on patch 4
> - can you please rebase and resend?

Done.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
