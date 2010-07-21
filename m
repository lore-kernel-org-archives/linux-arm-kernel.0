From: fabioestevam@yahoo.com (Fabio Estevam)
Date: Wed, 21 Jul 2010 16:59:31 -0700 (PDT)
Subject: [PATCH 2/5] mx25: Add flexcan devices
In-Reply-To: <1279749595-21596-3-git-send-email-mkl@pengutronix.de>
Message-ID: <911441.33834.qm@web51008.mail.re2.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marc,

--- On Wed, 7/21/10, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
...
>  
> +static struct resource mxc_i2c_1_resources[] = {
> +??? {
> +??? ???

Shouldn't the inclusion of i2c be handled by a separate patch?

Regards,

Fabio Estevam 


      
