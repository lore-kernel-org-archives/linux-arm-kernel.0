From: dan.j.williams@intel.com (Dan Williams)
Date: Wed, 24 Mar 2010 16:03:02 -0700
Subject: [PATCH 1/5] ARM: define the PrimeCell DMA API
In-Reply-To: <CEE6BB42CAD6E947908279175AF8470A0391EEB6@EXDCVYMBSTM006.EQ1STM.local>
References: <1268056327-16577-1-git-send-email-linus.walleij@stericsson.com>
	<e9c3a7c21003241425m595f983fg520c9cace7ddce91@mail.gmail.com>
	<CEE6BB42CAD6E947908279175AF8470A0391EEB6@EXDCVYMBSTM006.EQ1STM.local>
Message-ID: <e9c3a7c21003241603j4e5b948asfdecbb00f17bedd9@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 24, 2010 at 3:08 PM, Linus WALLEIJ
<linus.walleij@stericsson.com> wrote:
> Do you prefer this latter solution? I'm OK with either, I just
> think the runtime dma_set_ambaconfig() is a bit more elegant.

I agree, too many hoops to jump through to shoehorn it into the
current api.  Let's go with your current amba specific version for
now.

--
Dan
