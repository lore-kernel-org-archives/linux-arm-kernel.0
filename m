From: richardcochran@gmail.com (Richard Cochran)
Date: Thu, 11 Oct 2012 07:09:48 +0200
Subject: Booting vanilla kernel on the beaglebone
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EB3A700@DBDE01.ent.ti.com>
References: <20121008191657.GA3281@netboy.at.omicron.at>
 <79CD15C6BA57404B839C016229A409A83EB39685@DBDE01.ent.ti.com>
 <20121009110049.GB2274@netboy.at.omicron.at>
 <79CD15C6BA57404B839C016229A409A83EB39D66@DBDE01.ent.ti.com>
 <20121009114326.GA4511@netboy.at.omicron.at>
 <79CD15C6BA57404B839C016229A409A83EB39F42@DBDE01.ent.ti.com>
 <20121009165405.GB6870@netboy.at.omicron.at>
 <79CD15C6BA57404B839C016229A409A83EB3A636@DBDE01.ent.ti.com>
 <20121009182941.GB12235@netboy.at.omicron.at>
 <79CD15C6BA57404B839C016229A409A83EB3A700@DBDE01.ent.ti.com>
Message-ID: <20121011050948.GA2577@netboy.at.omicron.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 09, 2012 at 06:34:18PM +0000, Hiremath, Vaibhav wrote:
> 
> As I mentioned they are expected to get merged for rc1 and result of 
> integration during merge window.

There is a DT binding document

   Documentation/devicetree/bindings/net/cpsw.txt

but cpsw does not appear in either am335x-bone.dts, am335x-evm.dts, or
am33xx.dtsi, or for that matter, in *any* dts file anywhere. I have
looked in mainline master, linux-next, and in the master branch of

   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git

Is there an issue keeping the cpsw/DT combination from working?
If not, is there a file dts for the bealgebone somewhere?

Thanks,
Richard
