From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Tue, 12 Jul 2011 22:42:13 +0200
Subject: [PATCH 0/4] OMAP: PM: omap_device: update PM domain support for
	v3.1
In-Reply-To: <1310426969-30306-1-git-send-email-khilman@ti.com>
References: <1310426969-30306-1-git-send-email-khilman@ti.com>
Message-ID: <201107122242.13837.rjw@sisk.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tuesday, July 12, 2011, Kevin Hilman wrote:
> For v3.1, the PM core has some changes that impact various assumptions
> made (by me) during the design and implementation of the PM domain
> support in the omap_device layer.
> 
> This series is needed to update our PM domain layer to behave properly
> under the new rules of the PM core code which are planned to be merged
> for v3.1 (see recent linux-pm discussions for the gory details.)
> 
> This series is based on the pm-domains branch of Rafael Wysocki's
> suspend-2.6 tree, and also depends on the patch which adds
> pm_runtime_status_suspended() helper function[1].
> 
> Rafael, because of the dependencies on your pm-domains branch (due to
> the pwr_domain -> pm_domain rename), it might be easiest to merge
> these via your tree.   Let me know if that's OK with you.

Yes, it is.  I'm going to apply them to my pm-runtime branch that is based
on pm-domains.

Thanks,
Rafael
