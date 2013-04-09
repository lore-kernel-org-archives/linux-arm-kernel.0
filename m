From: sameo@linux.intel.com (Samuel Ortiz)
Date: Tue, 9 Apr 2013 15:00:52 +0200
Subject: [PATCH 2/2] mfd: db8500-prcmu: Support platform dependant device
 selection
In-Reply-To: <20130409100609.GQ24058@zurbaran>
References: <1365071941-23475-1-git-send-email-lee.jones@linaro.org>
 <1365071941-23475-2-git-send-email-lee.jones@linaro.org>
 <20130409100609.GQ24058@zurbaran>
Message-ID: <20130409130052.GA9172@zurbaran>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In case you did not get this one...

On Tue, Apr 09, 2013 at 12:06:09PM +0200, Samuel Ortiz wrote:
> Hi Lee,
> 
> On Thu, Apr 04, 2013 at 11:39:01AM +0100, Lee Jones wrote:
> > The main aim for this cycle is to have the u8540 booting to a
> > console. However, the u8540 doesn't support all of the u8500
> > platform devices yet. After this stage is complete we can then
> > fill in the inadequacies, such as specific clock support at a
> > later date. To achieve this we're placing devices supported by
> > all platforms into a common device structure and the remaining
> > ones into a platform specific one.
> > 
> > Cc: Samuel Ortiz <sameo@linux.intel.com>
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  drivers/mfd/db8500-prcmu.c |   52 ++++++++++++++++++++++++++++----------------
> >  1 file changed, 33 insertions(+), 19 deletions(-)
> This one does not apply (not even manually) on top of mfd-next. Would you mind
> rebasing it (And adding Linus' ACK) ?
> 
> Cheers,
> Samuel.
> 
> -- 
> Intel Open Source Technology Centre
> http://oss.intel.com/

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
