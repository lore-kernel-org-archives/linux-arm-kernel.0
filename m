From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Mon, 30 Sep 2013 11:59:39 -0600
Subject: [PATCH v2 1/3] ARM: kirkwood: Remove kirkwood_setup_wins and
 rely on the DT binding (Was Re: ..)
In-Reply-To: <20130930175611.GA2607@localhost>
References: <20130917184146.GD21230@obsidianresearch.com>
 <20130929203314.GA2457@localhost>
 <20130930174245.GB28898@obsidianresearch.com>
 <20130930175611.GA2607@localhost>
Message-ID: <20130930175939.GE28898@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 30, 2013 at 02:56:12PM -0300, Ezequiel Garcia wrote:
> Well, I booted the board with the patch, but didn't do any crypto-specific
> testings. That said, I don't have any strong opinion on the crypto-node moving
> or splitting.
> 
> Have you worked that out?

I feel it is the same situation as the NAND, moving it doesn't
preclude any future fixups. Keeping it outside the mbus node is
mis-using the mbus binding.

Jason
