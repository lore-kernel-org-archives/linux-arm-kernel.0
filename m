From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 16 Mar 2010 13:23:05 +0000
Subject: [PATCH 7/8] [ARM] pxa: move ssp into common plat-pxa
In-Reply-To: <f17812d71003160604q38846792i18efbcf9fb7208f@mail.gmail.com>
References: <1268740373-27407-1-git-send-email-eric.y.miao@gmail.com>
	<1268740373-27407-8-git-send-email-eric.y.miao@gmail.com>
	<771cded01003160549t73b30cccr7ba56722c28f013c@mail.gmail.com>
	<20100316125955.GB7287@rakim.wolfsonmicro.main>
	<f17812d71003160604q38846792i18efbcf9fb7208f@mail.gmail.com>
Message-ID: <20100316132305.GA8875@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 16, 2010 at 09:04:22PM +0800, Eric Miao wrote:

> So do you have any detailed plan in your mind? I'm basically thinking if
> it's possible to setup a common topic branch with pxa-ssp changes to
> be a common baseline for both trees.

How about creating a branch off 2.6.34-rc1, doing the updates that need
to be shared on that branch and then when we're happy pulling that topic
branch into both the PXA and ASoC development trees?  If required we can
always merge that branch multiple times into our trees.
