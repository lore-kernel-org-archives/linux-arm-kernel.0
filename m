From: mturquette@baylibre.com (Michael Turquette)
Date: Wed, 17 Feb 2016 11:57:25 -0800
Subject: [PATCH] clk: imx: correct pwm7 clock name in driver for i.MX6UL
In-Reply-To: <CAOMZO5Cwed8uOKz6=Odu=jaaBqoNzUxm2Xv3+6TAxKGsa27Mdw@mail.gmail.com>
References: <1455734900-1913-1-git-send-email-agust@denx.de>
 <CAOMZO5Cwed8uOKz6=Odu=jaaBqoNzUxm2Xv3+6TAxKGsa27Mdw@mail.gmail.com>
Message-ID: <20160217195725.2278.96780@quark.deferred.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Fabio Estevam (2016-02-17 10:58:13)
> On Wed, Feb 17, 2016 at 4:48 PM, Anatolij Gustschin <agust@denx.de> wrote:
> > Don't capitalize p in the pwm7 clock name.
> >
> > Signed-off-by: Anatolij Gustschin <agust@denx.de>
> 
> Thanks.
> 
> Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>

Should I apply this to clk-next or is someone (Shawn?) gathering patches
for a pull request?

Regards,
Mike

> --
> To unsubscribe from this list: send the line "unsubscribe linux-clk" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
