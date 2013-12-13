From: mturquette@linaro.org (Mike Turquette)
Date: Thu, 12 Dec 2013 17:51:58 -0800
Subject: [PATCH 22/41] clk: ux500: Copy u8500_clk_init() ready for DT
 enablement
In-Reply-To: <CACRpkdZ+kg8VEMZ6gy6CG=YK0Ycj-Ud-UuRohzKgE4UW_VUMjg@mail.gmail.com>
References: <1379506478-16625-1-git-send-email-lee.jones@linaro.org>
 <1379506478-16625-23-git-send-email-lee.jones@linaro.org>
 <CACRpkdZ+kg8VEMZ6gy6CG=YK0Ycj-Ud-UuRohzKgE4UW_VUMjg@mail.gmail.com>
Message-ID: <20131213015158.11981.27135@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Linus Walleij (2013-09-20 13:59:46)
> On Wed, Sep 18, 2013 at 2:14 PM, Lee Jones <lee.jones@linaro.org> wrote:
> 
> > Here we're using the old clock initialisation function as a template.
> > It's necessary to remove all of the clk_register_clkdev() calls as
> > they don't make sense when booting with Device Tree.
> >
> > Cc: Mike Turquette <mturquette@linaro.org>
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> 
> I *really* like the looks of this! Mike can we have your ACK on this?

Acked-by: Mike Turquette <mturquette@linaro.org>

> 
> Yours,
> Linus Walleij
