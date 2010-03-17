From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 17 Mar 2010 10:05:38 +0000
Subject: [PATCH 7/8] [ARM] pxa: move ssp into common plat-pxa
In-Reply-To: <f17812d71003162214y10e98491v928b5c51d1bf2616@mail.gmail.com>
References: <1268740373-27407-1-git-send-email-eric.y.miao@gmail.com>
	<1268740373-27407-8-git-send-email-eric.y.miao@gmail.com>
	<771cded01003160549t73b30cccr7ba56722c28f013c@mail.gmail.com>
	<20100316125955.GB7287@rakim.wolfsonmicro.main>
	<f17812d71003160604q38846792i18efbcf9fb7208f@mail.gmail.com>
	<20100316132305.GA8875@rakim.wolfsonmicro.main>
	<f17812d71003160647v22569487k4f767da7dae6d298@mail.gmail.com>
	<20100316140834.GB9365@rakim.wolfsonmicro.main>
	<f17812d71003162214y10e98491v928b5c51d1bf2616@mail.gmail.com>
Message-ID: <20100317100538.GC13166@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 17, 2010 at 01:14:39PM +0800, Eric Miao wrote:

> I'm seeing no merge conflict between my ssp_cleanup and Takashi's
> latest tree, which branch do you suggest to merge then?

I'm not sure what you're asking here but if you're looking for any
incompatible changes in ASoC they've not been implemented yet, the issue
is that due to the stuff Liam is working on at the minute there are
likely to be incompatible changes in the current release cycle which
would mean that merging new drivers (like Haojian posted) via a non-ALSA
tree would lead to problems after the trees are been merged together.
