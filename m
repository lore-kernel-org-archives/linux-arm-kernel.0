From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 15 Jun 2016 22:38:28 +0530
Subject: [PATCH 8/8] dmaengine: Remove site specific OOM error messages
 on kzalloc
In-Reply-To: <CACRpkdaf1d8CvBmFCT+bWiXR9ddJ0Mpu5hMi2fzR6sLCXt3EqA@mail.gmail.com>
References: <1465321121-22238-1-git-send-email-peter.griffin@linaro.org>
 <1465321121-22238-9-git-send-email-peter.griffin@linaro.org>
 <CACRpkdaf1d8CvBmFCT+bWiXR9ddJ0Mpu5hMi2fzR6sLCXt3EqA@mail.gmail.com>
Message-ID: <20160615170828.GD16910@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 08, 2016 at 02:12:27PM +0200, Linus Walleij wrote:
> On Tue, Jun 7, 2016 at 7:38 PM, Peter Griffin <peter.griffin@linaro.org> wrote:
> 
> > If kzalloc() fails it will issue it's own error message including
> > a dump_stack(). So remove the site specific error messages.
> >
> > Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 
> A few subsystems may use a cleanup like this...
> I wonder how many unnecessary prints I've introduced
> myself :P

Yes that should be case with mine too :)

I think adding a coccinelle script and doing this treewise might be great

Thanks
-- 
~Vinod
