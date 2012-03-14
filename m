From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 14 Mar 2012 19:15:01 -0300
Subject: [PATCH v3 6/6] mfd: mc13xxx: Add i2c driver
In-Reply-To: <1331757790-10583-7-git-send-email-marc@cpdesign.com.au>
References: <1331757790-10583-1-git-send-email-marc@cpdesign.com.au>
 <1331757790-10583-7-git-send-email-marc@cpdesign.com.au>
Message-ID: <CAOMZO5BVObpszMd4_dDr3NHw9-oXh9wY_T48UA2vMWozdUyukw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On Wed, Mar 14, 2012 at 5:43 PM, Marc Reilly <marc@cpdesign.com.au> wrote:

> +
> +static const struct i2c_device_id mc13xxx_i2c_device_id[] = {
> + ? ? ? {
> + ? ? ? ? ? ? ? .name = "mc13783",
> + ? ? ? ? ? ? ? .driver_data = MC13XXX_ID_MC13783

mc13783 does not have i2c interface.
