From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 14 Feb 2013 17:41:34 +0000
Subject: [PATCH 06/15] clk: export __clk_get_name
In-Reply-To: <201301221543.18859.arnd@arndb.de>
References: <1358788568-11137-1-git-send-email-arnd@arndb.de>
 <CAOMZO5AON+FhTQpTbEdjwZaEaxsPoEVLeALhH2s34biWH_EeOA@mail.gmail.com>
 <201301221543.18859.arnd@arndb.de>
Message-ID: <201302141741.34474.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 22 January 2013, Arnd Bergmann wrote:
> On Tuesday 22 January 2013, Fabio Estevam wrote:
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > > Cc: Sascha Hauer <s.hauer@pengutronix.de>
> > > Cc: Mike Turquette <mturquette@linaro.org>
> > 
> > A fix from Niels de Vos has already been applied into clk-next:
> > https://patchwork.kernel.org/patch/1871981/
> 
> Ok, very good. Mike, I saw that the patch is over
> a month old. Any reason it hasn't made it into v3.8.rc yet?
> 

I guess we missed this one for 3.8 then, meaning we have no
working allmodconfig :(

	Arnd
