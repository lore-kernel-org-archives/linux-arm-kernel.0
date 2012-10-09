From: richardcochran@gmail.com (Richard Cochran)
Date: Tue, 9 Oct 2012 18:47:16 +0200
Subject: Booting vanilla kernel on the beaglebone
In-Reply-To: <EB1619762EAF8B4E97A227FB77B7E0293E9F27CE@DBDE01.ent.ti.com>
References: <20120930082802.GA15392@netboy.at.omicron.at>
 <50740AB0.7080102@ti.com>
 <EB1619762EAF8B4E97A227FB77B7E0293E9F27CE@DBDE01.ent.ti.com>
Message-ID: <20121009164716.GA6870@netboy.at.omicron.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 09, 2012 at 04:27:03PM +0000, N, Mugunthan V wrote:
> 
> I have implemented the CPTS hardware clock and will be submitting the
> patches soon to TI's kernel repo and also planning to submit the patches
> to Mainline kernel mailing lists soon.

I did see the stuff you added into arago for the DM814x, but it didn't
look correct to me.

Anyhow, I went ahead and wrote my own from stratch, based on the
AM335XPSP_04.06.00.08 branch, and it is working well. So go ahead and
post your driver, and I'll post mine, and we can go from there.

Right now, I can't for the life of me get a mainline kernel to boot on
the beaglebone, so I think we should focus on getting the mainline
support on the am335x stable before adding new drivers.

Thanks,
Richard
