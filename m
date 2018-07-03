From: yibin.gong@nxp.com (Robin Gong)
Date: Tue, 3 Jul 2018 02:57:13 +0000
Subject: [PATCH v5 0/7] add virt-dma support for imx-sdma
In-Reply-To: <20180702131737.GJ22377@vkoul-mobl>
References: <1529427424-12321-1-git-send-email-yibin.gong@nxp.com>
 <1530025442.9910.44.camel@pengutronix.de>
 <1530527489.15665.22.camel@nxp.com> <20180702131737.GJ22377@vkoul-mobl>
Message-ID: <1530615395.15665.26.camel@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On ?, 2018-07-02 at 18:47 +0530, Vinod wrote:
> On 02-07-18, 02:32, Robin Gong wrote:
> > 
> > Hi Vinod,
> > 	Do you have any comment for this patchset? Lucas and Sascha
> > acked it and tty patch already merged in.
> I was actually waiting for ACK/action on patch 1 :)
> 
> I have reviewed the series, some nitpicks nothing major, so I have
> applied this good cleanup and conversion :) along with fixes for
> typos
> in code, GFP_ fix and removed unused variable.
> 
> My buildchain noticed warns (with W=1) on this file, esp now that
> structs are moved around. Pls fix the struct descriptions.
Okay, I'll send another patch to fix such build warning issue later.
BTW, patch 1 has already been in linux-next tree :).
> 
> Thanks
