From: pawel.moll@arm.com (Pawel Moll)
Date: Wed, 11 Jul 2012 17:58:36 +0100
Subject: [PATCH 3/9] ARM: versatile: Make plat-versatile clock optional
In-Reply-To: <CACRpkdYiW8C298K3uPzfJrq09vs-r90brMT_imgz54KtP4Xqsw@mail.gmail.com>
References: <1342013791-19516-1-git-send-email-pawel.moll@arm.com>
 <1342013791-19516-4-git-send-email-pawel.moll@arm.com>
 <CACRpkdYiW8C298K3uPzfJrq09vs-r90brMT_imgz54KtP4Xqsw@mail.gmail.com>
Message-ID: <1342025916.25865.4.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2012-07-11 at 17:43 +0100, Linus Walleij wrote:
> On Wed, Jul 11, 2012 at 3:36 PM, Pawel Moll <pawel.moll@arm.com> wrote:
> 
> > ... in preparation for common clock coming for Integrator
> > and Versatile Express.
> >
> > Based on Linus Walleij's "ARM: integrator: convert to common
> > clock" patch.
> >
> > Signed-off-by: Pawel Moll <pawel.moll@arm.com>
> 
> I think Mike is already queueing my patch, so if you're changing
> anything you should build on top of that and submit it to the
> clk tree.

That's why I split this part to a separate patch. When it comes to merge
the arm-soc people will be able to drop it completely.

Pawe?
