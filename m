From: clabbe.montjoie@gmail.com (LABBE Corentin)
Date: Tue, 17 Nov 2015 15:26:03 +0100
Subject: [PATCH] crypto: sun4i-ss: add missing statesize
In-Reply-To: <20151117140938.GH9546@gondor.apana.org.au>
References: <1447420229-17911-1-git-send-email-clabbe.montjoie@gmail.com>
 <20151117140938.GH9546@gondor.apana.org.au>
Message-ID: <20151117142603.GA1669@Red>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 17, 2015 at 10:09:38PM +0800, Herbert Xu wrote:
> On Fri, Nov 13, 2015 at 02:10:28PM +0100, LABBE Corentin wrote:
> > sun4i-ss implementaton of md5/sha1 is via ahash algorithms.
> > Commit 8996eafdcbad ("crypto: ahash - ensure statesize is non-zero")
> > made impossible to load them without giving statesize. This patch
> > specifiy statesize for sha1 and md5.
> > 
> > Fixes: 6298e948215f ("crypto: sunxi-ss - Add Allwinner Security System crypto accelerator")
> > Cc: <stable@vger.kernel.org> # v4.3+
> > Tested-by: Chen-Yu Tsai <wens@csie.org>
> > Signed-off-by: LABBE Corentin <clabbe.montjoie@gmail.com>
> 
> Patch applied to cryptodev as I don't think it needs to go into
> stable straight away.  Thanks.

Hello

I have lots of user reporting that they cannot use the device since it wont load.
For me it need to go stable since it respect all "stable rules", simple, tested, minimal, and fix a real bug that bother people.

Thanks in advance.
Regards
