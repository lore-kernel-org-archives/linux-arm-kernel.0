From: fernando.lugo@ti.com (Guzman Lugo, Fernando)
Date: Tue, 26 Oct 2010 10:50:02 -0500
Subject: [PATCH 8/8] staging: tidspbridge - make sync_wait_on_event
	interruptible
In-Reply-To: <AANLkTinnLb9DLMKfxEs_KqMvOmegSDYRuLWh5y=hhBCe@mail.gmail.com>
References: <1288054306-4361-1-git-send-email-x0095840@ti.com>
	<1288054306-4361-2-git-send-email-x0095840@ti.com>
	<1288054306-4361-3-git-send-email-x0095840@ti.com>
	<1288054306-4361-4-git-send-email-x0095840@ti.com>
	<1288054306-4361-5-git-send-email-x0095840@ti.com>
	<1288054306-4361-6-git-send-email-x0095840@ti.com>
	<1288054306-4361-7-git-send-email-x0095840@ti.com>
	<1288054306-4361-8-git-send-email-x0095840@ti.com>
	<1288054306-4361-9-git-send-email-x0095840@ti.com>
	<AANLkTinnLb9DLMKfxEs_KqMvOmegSDYRuLWh5y=hhBCe@mail.gmail.com>
Message-ID: <496565EC904933469F292DDA3F1663E602F49E2802@dlee06.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 

> -----Original Message-----
> From: Felipe Contreras [mailto:felipe.contreras at gmail.com] 
> Sent: Monday, October 25, 2010 7:59 PM
> To: Guzman Lugo, Fernando
> Cc: gregkh at suse.de; felipe.contreras at nokia.com; 
> Hiroshi.DOYU at nokia.com; linux-kernel at vger.kernel.org; 
> andy.shevchenko at gmail.com; linux-omap at vger.kernel.org; 
> linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH 8/8] staging: tidspbridge - make 
> sync_wait_on_event interruptible
> 
> On Tue, Oct 26, 2010 at 3:51 AM, Fernando Guzman Lugo 
> <x0095840@ti.com> wrote:
> > So that avoid non-killable process.
> 
> It would be useful to interrupt these tasks from user-space. 
> A separate ioctl to do that would be needed.

I don't see use case where that could be needed. It is only
To avoid a nonkillable task in the case the user pass an infinite
Timeout.

If you have some test case where that ioctl would be needed
Please share it in order to find the best solution.

Regards,
Fernando.

> 
> --
> Felipe Contreras
> 
