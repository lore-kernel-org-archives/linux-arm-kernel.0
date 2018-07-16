From: logang@deltatee.com (Logan Gunthorpe)
Date: Sun, 15 Jul 2018 22:48:37 -0600
Subject: next/master boot: 184 boots: 13 failed, 171 passed (next-20180711)
In-Reply-To: <20180716083144.499eb2c6@canb.auug.org.au>
References: <5b45f6df.1c69fb81.86409.6375@mx.google.com>
 <20180711145253.GA9651@sirena.org.uk>
 <CAOMZO5B+LBwAEewEoCn=TojQuZ=qMt+4a8n+tiG9cfnzAta_9w@mail.gmail.com>
 <20180712100809.10ac3e1d@canb.auug.org.au>
 <20180714121046.7a9cdf20@canb.auug.org.au>
 <1bdd19e5-036d-0979-f360-14a43e3e986d@deltatee.com>
 <20180716083144.499eb2c6@canb.auug.org.au>
Message-ID: <1484e486-1c19-a803-2967-7dec9e84d351@deltatee.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 15/07/18 04:31 PM, Stephen Rothwell wrote:
> OK, so I have removed the following from linux-next today:
> 
> 0b845db3ac65 ntb: ntb_hw_switchtec: cleanup 64bit IO defines to use the common header
> 6d997075ea14 crypto: caam: cleanup CONFIG_64BIT ifdefs when using io{read|write}64
> 9d235749060f ntb: ntb_hw_intel: use io-64-nonatomic instead of in-driver hacks
> 1a516b53c12d io-64-nonatomic: add io{read|write}64[be]{_lo_hi|_hi_lo} macros
> ddc62940244b iomap: introduce io{read|write}64_{lo_hi|hi_lo}
> 6f595ae8ed85 parisc: iomap: introduce io{read|write}64
> b68c7928b65d iomap: use non-raw io functions for io{read|write}XXbe
> 
> Let me know if that is correct or otherwise.

That's correct.

Thanks,

Logan
