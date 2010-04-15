From: dan.j.williams@intel.com (Dan Williams)
Date: Wed, 14 Apr 2010 18:15:21 -0700
Subject: [PATCH 00/11] ARM: PrimeCell DMA Interface v5
In-Reply-To: <CEE6BB42CAD6E947908279175AF8470A03A50F78@EXDCVYMBSTM006.EQ1STM.local>
References: <1270681920-4461-1-git-send-email-linus.walleij@stericsson.com>
	<v2se9c3a7c21004071645u8180f4d7p3b4b1f96de11303e@mail.gmail.com>
	<CEE6BB42CAD6E947908279175AF8470A03A50F78@EXDCVYMBSTM006.EQ1STM.local>
Message-ID: <t2qe9c3a7c21004141815x70ecf123p4364802681417da9@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Wed, Apr 7, 2010 at 11:35 PM, Linus WALLEIJ
<linus.walleij@stericsson.com> wrote:
> If it's OK with Russell, putting 04-06 plus 09 through async_tx
> tree is a good starter.

Getting closer... I have pushed out the dma40 driver (v3), 4, and 6.
The other patch in -mm I could take as well but that needs an ack from
Russell.

5 is pending the review comment and 9 does not apply cleanly (does it
depend on something in the spi tree?)

--
Dan
