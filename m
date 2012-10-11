From: mugunthanvnm@ti.com (N, Mugunthan V)
Date: Thu, 11 Oct 2012 21:20:24 +0000
Subject: Booting vanilla kernel on the beaglebone
In-Reply-To: <5076B2FE.8040000@ti.com>
References: <20121011050948.GA2577@netboy.at.omicron.at>
 <5076B2FE.8040000@ti.com>
Message-ID: <EB1619762EAF8B4E97A227FB77B7E0293E9F451D@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -------- Original Message --------
> Subject: Re: Booting vanilla kernel on the beaglebone
> Date: Thu, 11 Oct 2012 07:09:48 +0200
> From: Richard Cochran <richardcochran@gmail.com>
> To: Hiremath, Vaibhav <hvaibhav@ti.com>
> CC: linux-arm-kernel at lists.infradead.org
> <linux-arm-kernel@lists.infradead.org>
> 
> On Tue, Oct 09, 2012 at 06:34:18PM +0000, Hiremath, Vaibhav wrote:
> >
> > As I mentioned they are expected to get merged for rc1 and result of
> > integration during merge window.
> 
> There is a DT binding document
> 
>    Documentation/devicetree/bindings/net/cpsw.txt
> 
> but cpsw does not appear in either am335x-bone.dts, am335x-evm.dts, or
> am33xx.dtsi, or for that matter, in *any* dts file anywhere. I have
> looked in mainline master, linux-next, and in the master branch of
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git
> 
> Is there an issue keeping the cpsw/DT combination from working?
> If not, is there a file dts for the bealgebone somewhere?

Richard

I have a working branch for CPSW which is based on 3.5.0-rc6 in the following git repo
Repo: https://github.com/hvaibhav/am335x-linux.git
Branch: am335x-linux-next-master-cpsw

Regards
Mugunthan V N
