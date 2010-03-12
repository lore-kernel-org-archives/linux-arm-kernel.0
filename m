From: gadiyar@ti.com (Gadiyar, Anand)
Date: Fri, 12 Mar 2010 16:07:50 +0530
Subject: [PATCH 12/19] omap: Fix gpio_resume_after_retention
In-Reply-To: <A24693684029E5489D1D202277BE894453FB1216@dlee02.ent.ti.com>
References: <20100311234404.4500.82861.stgit@baageli.muru.com>
	<20100311234834.4500.12726.stgit@baageli.muru.com>
	<A24693684029E5489D1D202277BE894453FB11F8@dlee02.ent.ti.com>
	<20100311235640.GW2900@atomide.com>
	<A24693684029E5489D1D202277BE894453FB1216@dlee02.ent.ti.com>
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0321EC96B2@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> I normally send my patches with this alias:
> 
> alias gsend='git send-email --smtp-server /usr/bin/msmtp 
> --from "Sergio Aguirre <saaguirre@ti.com>" 
> --envelope-sender="Sergio Aguirre <saaguirre@ti.com>"'
> 
> and then just do:
> 
> gsend --to='linux-omap at vger.kernel.org' 
> patches/forLO_20100311/0001-mypatch.patch
> 
> But somehow the patch ends up (I'm guessing through TI LDAP 
> server) changing that to "Aguirre, Sergio"...
> 
> and also Patchworks seems to continue display my old 
> fullname: "Aguirre Rodriguez, Sergio Alberto"... I guess it's 
> in a static data cache somewhere, maybe?
> 
> Does anyone know how to overcome this kind of scenario, and 
> force what --from param says?

I send patches with an explicit "From: Anand Gadiyar <gadiyar@ti.com>"
line in the content. This seems to work okay.

Can you check if this works for you?

- Anand
