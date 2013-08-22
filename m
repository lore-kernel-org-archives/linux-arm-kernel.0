From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Thu, 22 Aug 2013 10:06:46 +0200
Subject: [PATCH v7 3/7] gpio: samsung: Skip initialization if device tree
 is present
In-Reply-To: <CACRpkda2ZjPm4nEeDujPWSDCNLk4mr9izPvhqNKx5urVAg_Azg@mail.gmail.com>
References: <1377120111-25601-1-git-send-email-tomasz.figa@gmail.com>
 <1377120111-25601-4-git-send-email-tomasz.figa@gmail.com>
 <CACRpkda2ZjPm4nEeDujPWSDCNLk4mr9izPvhqNKx5urVAg_Azg@mail.gmail.com>
Message-ID: <3452017.UPhKO6xNO5@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 22 of August 2013 01:21:25 Linus Walleij wrote:
> On Wed, Aug 21, 2013 at 11:21 PM, Tomasz Figa <tomasz.figa@gmail.com> 
wrote:
> > Since this driver does not handle GPIO on device tree enabled
> > platforms
> > any more, it should be bypassed whenever device tree is available, to
> > not conflict with the new pinctrl-samsung driver.
> > 
> > Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
> 
> This seems like something I should apply to the GPIO tree
> right now, shall I?

Would be nice, but since this patch is a dependency for rest of this 
series and there are no other dependencies on GPIO tree, it might be 
easier to just let Kukjin take all the patches with required Acks.

Best regards,
Tomasz
