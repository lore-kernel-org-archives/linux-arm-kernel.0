From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 5 Jul 2012 15:38:37 +0000
Subject: [PATCH] of: address: Don't fail a lookup just because a node has
 no reg property
In-Reply-To: <4FF5B004.4080100@linaro.org>
References: <1341498754-30445-1-git-send-email-lee.jones@linaro.org>
 <4FF5AB4D.6090500@gmail.com> <4FF5B004.4080100@linaro.org>
Message-ID: <201207051538.37687.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 05 July 2012, Lee Jones wrote:
> >
> > Acked-by: Rob Herring <rob.herring@calxeda.com>
> >
> > Do you have something dependent on this or want me to apply?
> 
> I have things that require this patch yes. Please apply.

I guess Rob's question was whether you want to keep this together
with the patch that depends on it rather than him applying just
the one patch.

	Arnd
