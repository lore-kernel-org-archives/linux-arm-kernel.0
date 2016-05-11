From: peter.griffin@linaro.org (Peter Griffin)
Date: Wed, 11 May 2016 17:22:58 +0100
Subject: [PATCH] i2c: st: Implement i2c_bus_recovery_info callbacks
In-Reply-To: <20160424211044.GD4317@katana>
References: <1460467759-11737-1-git-send-email-peter.griffin@linaro.org>
 <20160424211044.GD4317@katana>
Message-ID: <20160511162258.GA381@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,

On Sun, 24 Apr 2016, Wolfram Sang wrote:

> > +/*
> > + * i2c bus recovery routines
> > + * get_scl and set_scl must be defined to avoid the recover_bus field of
> > + * i2c_bus_recovery_info to be overriden with NULL during the
> > + * i2c_add_adapter call
> > + */
> 
> Oh, that shouldn't be like this. Can you try this patch and remove the
> empty functions please?

That works, so will need to be applied along with my v2 which I just sent.

regards,

Peter.
