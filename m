From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 11 May 2010 18:46:21 +0800
Subject: [PATCH 2/4] pxa/colibri270: Add MMC support
In-Reply-To: <20100511085216.GR30801@buzzloop.caiaq.de>
References: <1273544818-22305-1-git-send-email-marek.vasut@gmail.com>
	<1273544818-22305-2-git-send-email-marek.vasut@gmail.com>
	<20100511085216.GR30801@buzzloop.caiaq.de>
Message-ID: <AANLkTinMixSxs0H-shm7E8OoB9ErZIcklqFuz_echLW3@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 11, 2010 at 4:52 PM, Daniel Mack <daniel@caiaq.de> wrote:
> On Tue, May 11, 2010 at 04:26:56AM +0200, Marek Vasut wrote:
>> Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
>
> The rest of this set also looks ok to me.
>
> For the future, we should think about having a modularized aproach for
> these modules just like some mx31 boards have. We would need to split
> resources on the module from such on the baseboard, so peope can easily
> add support for a custom base board without touching the module code.
>

Daniel,

So Ack for this patch or not?
