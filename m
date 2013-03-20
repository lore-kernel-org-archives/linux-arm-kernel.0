From: dahuang@nvidia.com (Danny Huang)
Date: Wed, 20 Mar 2013 10:20:03 +0800
Subject: [PATCH] ARM: tegra: fuse: add fuctions to read speedo id and
 process id
In-Reply-To: <514915DB.8060206@wwwdotorg.org>
References: <1363660405-10668-1-git-send-email-dahuang@nvidia.com>
 <5148A8D6.8000002@wwwdotorg.org> <1363743557.3573.50.camel@dahuang-vm>
 <514915DB.8060206@wwwdotorg.org>
Message-ID: <1363746003.3573.80.camel@dahuang-vm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-03-20 at 09:50 +0800, Stephen Warren wrote:
> On 03/19/2013 07:39 PM, Danny Huang wrote:
> > On Wed, 2013-03-20 at 02:05 +0800, Stephen Warren wrote:
> >> On 03/18/2013 08:33 PM, Danny Huang wrote:
> >>> Add functions to read the speedo and process id of both cpu and soc.
> >>> There might be some drivers need the information as well.
> >>
> >> What code wants to use these functions? It'd be best to submit this
> >> patch with that code, so that something actually uses the functions, and
> >> they don't look like dead code.
> > 
> > There are some developing drivers that are located in drivers folder
> > needs those information.
> 
> Which drivers?

Per my understanding, there is a dvfs development that is trying to use
the devfreq framework.

> 
> > I think that they can't include a header file in mach-tegra folder
> 
> True.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-tegra" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
