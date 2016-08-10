From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 10 Aug 2016 15:45:30 +0200
Subject: [PATCH 0244/1285] Replace numeric parameter like 0444 with macro
In-Reply-To: <CACRpkdZsgSfL9rwe-vU5S6nNy0weD3O3PZymUZQsvJhQTSjf=w@mail.gmail.com>
References: <20160802105246.30008-1-baolex.ni@intel.com>
 <CACRpkdZsgSfL9rwe-vU5S6nNy0weD3O3PZymUZQsvJhQTSjf=w@mail.gmail.com>
Message-ID: <5052478.g1CZhtD17T@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, August 10, 2016 3:02:05 PM CEST Linus Walleij wrote:
> On Tue, Aug 2, 2016 at 12:52 PM, Baole Ni <baolex.ni@intel.com> wrote:
> 
> > I find that the developers often just specified the numeric value
> > when calling a macro which is defined with a parameter for access permission.
> > As we know, these numeric value for access permission have had the corresponding macro,
> > and that using macro can improve the robustness and readability of the code,
> > thus, I suggest replacing the numeric parameter with the macro.
> >
> > Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
> > Signed-off-by: Baole Ni <baolex.ni@intel.com>
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 
> I assume Wolfram will merge this.

I assume not, see http://lwn.net/Articles/696227/

	Arnd
