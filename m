From: hvaibhav@ti.com (Hiremath, Vaibhav)
Date: Thu, 28 Mar 2013 05:18:41 +0000
Subject: [PATCH 1/5] ARM: dts: AM33XX: Fix the i2c numbering to match
 hardware/TRM
In-Reply-To: <87k3ot6kq9.fsf@dell.be.48ers.dk>
References: <1364389156-8273-1-git-send-email-hvaibhav@ti.com>
 <1364389156-8273-2-git-send-email-hvaibhav@ti.com>
 <87k3ot6kq9.fsf@dell.be.48ers.dk>
Message-ID: <79CD15C6BA57404B839C016229A409A83EC3B9C6@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Peter Korsgaard [mailto:jacmet at gmail.com] On Behalf Of Peter
> Korsgaard
> Sent: Wednesday, March 27, 2013 6:52 PM
> To: Hiremath, Vaibhav
> Cc: linux-omap at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> Cousson, Benoit; Porter, Matt; devicetree-discuss at lists.ozlabs.org
> Subject: Re: [PATCH 1/5] ARM: dts: AM33XX: Fix the i2c numbering to
> match hardware/TRM
> 
> >>>>> "Vaibhav" == Vaibhav Hiremath <hvaibhav@ti.com> writes:
> 
>  Vaibhav> With DT support, where naming convention is based on base-
> addr
>  Vaibhav> and not id, so we should follow TRM/Spec numbering label.
> 
>  Vaibhav> This patch changes I2C numbering as per TRM, as I2C0, I2C1
> and I2C2.
> 
> Acked-by: Peter Korsgaard <jacmet@sunsite.dk>
> 
> What about the uart numbers while we're at it?
> 
Just responded to Matt on the same note,
I will change it and submit the next version with your acked-by.

Thanks,
Vaibhav
