From: fernando.lugo@ti.com (Guzman Lugo, Fernando)
Date: Tue, 26 Oct 2010 10:52:27 -0500
Subject: [PATCH 1/8] staging: tidspbridge - remove req_addr from proc_map
In-Reply-To: <AANLkTimCDM_nruvh_gqxxy0CVnw2sH5UYNT9VgyeBfZN@mail.gmail.com>
References: <1288054306-4361-1-git-send-email-x0095840@ti.com>
	<1288054306-4361-2-git-send-email-x0095840@ti.com>
	<AANLkTimCDM_nruvh_gqxxy0CVnw2sH5UYNT9VgyeBfZN@mail.gmail.com>
Message-ID: <496565EC904933469F292DDA3F1663E602F49E280A@dlee06.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 

> -----Original Message-----
> From: Felipe Contreras [mailto:felipe.contreras at gmail.com] 
> Sent: Tuesday, October 26, 2010 6:46 AM
> To: Guzman Lugo, Fernando
> Cc: gregkh at suse.de; felipe.contreras at nokia.com; 
> Hiroshi.DOYU at nokia.com; linux-kernel at vger.kernel.org; 
> andy.shevchenko at gmail.com; linux-omap at vger.kernel.org; 
> linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH 1/8] staging: tidspbridge - remove 
> req_addr from proc_map
> 
> On Tue, Oct 26, 2010 at 3:51 AM, Fernando Guzman Lugo 
> <x0095840@ti.com> wrote:
> > The device address is assigned by tidspbridge no need for 
> that parameter anymore.
> >
> > Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
> 
> This would break the API with user-space, right?

Yes, user-space needs to be changed accordingly.

> 
> I think this change should be delayed, preferably after we 
> have a working tidspbridge.

The issue you were seeing must be fixed with patch 2/8, and
Having all the dependencies tidspbridge has to be working
Properly.

Regards,
Fernando.

> 
> --
> Felipe Contreras
> 
