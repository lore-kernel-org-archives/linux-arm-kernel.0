From: dwalker@fifo99.com (Daniel Walker)
Date: Wed, 23 Mar 2011 19:24:27 -0700
Subject: [PATCH] msm: Add gpio support for 8960
In-Reply-To: <4D8A88AE.2000701@codeaurora.org>
References: <1300402640-23995-1-git-send-email-rvaswani@codeaurora.org>
	<1300885151.6117.11.camel@m0nster>  <4D8A88AE.2000701@codeaurora.org>
Message-ID: <1300933467.6117.49.camel@m0nster>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-03-23 at 16:56 -0700, Rohit Vaswani wrote:
> >>
> >> -	set_irq_chained_handler(TLMM_SCSS_SUMMARY_IRQ,
> >> +	set_irq_chained_handler(TLMM_MSM_SUMMARY_IRQ,
> >>   				msm_summary_irq_handler);
> > Ok, so looks like a rename. Can you add this to the commit text along
> > with descriptions of everything else your doing?
> Daniel,
> Adding support for 8960 includes making sure that Gpio support remains 
> meaningful and at the same time uniform across different boards. Should 
> we enumerate the specific changes ?

Should let everyone know exactly what your doing, even breaking up the
changes into specific patches.

Daniel
