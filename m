From: kgene@kernel.org (Kukjin Kim)
Date: Thu, 22 Aug 2013 18:45:01 +0900
Subject: [PATCH v7 3/7] gpio: samsung: Skip initialization if device tree
 is present
In-Reply-To: <CACRpkda2ZjPm4nEeDujPWSDCNLk4mr9izPvhqNKx5urVAg_Azg@mail.gmail.com>
References: <1377120111-25601-1-git-send-email-tomasz.figa@gmail.com>
 <1377120111-25601-4-git-send-email-tomasz.figa@gmail.com>
 <CACRpkda2ZjPm4nEeDujPWSDCNLk4mr9izPvhqNKx5urVAg_Azg@mail.gmail.com>
Message-ID: <1c7401ce9f1c$45c74130$d155c390$@org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus Walleij wrote:
> 
> On Wed, Aug 21, 2013 at 11:21 PM, Tomasz Figa <tomasz.figa@gmail.com>
> wrote:
> 
> > Since this driver does not handle GPIO on device tree enabled platforms
> > any more, it should be bypassed whenever device tree is available, to
> > not conflict with the new pinctrl-samsung driver.
> >
> > Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
> 
> This seems like something I should apply to the GPIO tree
> right now, shall I?
> 
I think so. Feel free to add my ack on this.

Acked-by: Kukjin Kim <kgene.kim@samsung.com>

Thanks,
Kukjin
