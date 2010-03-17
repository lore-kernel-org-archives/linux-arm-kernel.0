From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 17 Mar 2010 14:32:40 +0000
Subject: [PATCH 7/8] [ARM] pxa: move ssp into common plat-pxa
In-Reply-To: <f17812d71003170707g9290903ra98fa9f4d0942a86@mail.gmail.com>
References: <1268740373-27407-8-git-send-email-eric.y.miao@gmail.com>
	<771cded01003160549t73b30cccr7ba56722c28f013c@mail.gmail.com>
	<20100316125955.GB7287@rakim.wolfsonmicro.main>
	<f17812d71003160604q38846792i18efbcf9fb7208f@mail.gmail.com>
	<20100316132305.GA8875@rakim.wolfsonmicro.main>
	<f17812d71003160647v22569487k4f767da7dae6d298@mail.gmail.com>
	<20100316140834.GB9365@rakim.wolfsonmicro.main>
	<f17812d71003162214y10e98491v928b5c51d1bf2616@mail.gmail.com>
	<20100317100538.GC13166@opensource.wolfsonmicro.com>
	<f17812d71003170707g9290903ra98fa9f4d0942a86@mail.gmail.com>
Message-ID: <20100317143239.GB12208@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 17, 2010 at 10:07:12PM +0800, Eric Miao wrote:

> I tried a trivial merge of 'pxa-ssp' branch in your tree, and there's
> a conflict but it's fixable. There won't be much change to make in
> my 'ssp_cleanup' branch except for the pxa168 base support. What
> I can do is I'll try constantly merge of the asoc tree, and see if I can
> provide a conflict resolve which could be later used during upstream
> merge.

OK, I guess.  Please keep the SSP cleanup branch (including any ASoC
machine drivers) around so it can be merged both ways if needed.
