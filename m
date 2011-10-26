From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Wed, 26 Oct 2011 07:25:03 +0200
Subject: [PATCH 1/7] amp/remoteproc: add framework for controlling remote
	processors
In-Reply-To: <20111026051604.GT2638@game.jcrosoft.org>
References: <1319536106-25802-1-git-send-email-ohad@wizery.com>
	<1319536106-25802-2-git-send-email-ohad@wizery.com>
	<20111026051604.GT2638@game.jcrosoft.org>
Message-ID: <CAK=WgbaLcjnc1ApSwJ0zeTdjJpQzAnhYUZZ-kdtSKsHJun+FkQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 26, 2011 at 7:16 AM, Jean-Christophe PLAGNIOL-VILLARD > On
STM Soc > you can upload the firmware code where you want
> the you just have to specify in 2 register where the entry point of the co-pro

great, can you provide more info ? are you using an iommu ?

> BTW do you plan to support CMA as a lot of copro will request a big
> contineuous memory to work on between the cpus.

sure, this patch set is already using CMA.

> I've to go to the ELCE will continue the review later

come to "Tycho" today at 11:45 :)

Thanks,
Ohad.
