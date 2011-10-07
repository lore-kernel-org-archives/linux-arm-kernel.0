From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Fri, 7 Oct 2011 20:45:22 +0200
Subject: [PATCHv2] hw_random: add driver for atmel true hardware random
	number generator
In-Reply-To: <4E8ECC15.10704@atmel.com>
References: <1317923791-31200-1-git-send-email-jacmet@sunsite.dk>
	<4E8ECC15.10704@atmel.com>
Message-ID: <20111007184522.GA30518@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 07, 2011 at 11:53:25AM +0200, Nicolas Ferre wrote:
> On 10/06/2011 07:56 PM, Peter Korsgaard :
> > For the IP block on 9g45/9g46/9m10/9m11.
> > 
> > Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>
> 
> Thanks, I am delighted to see this driver!
> 
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> 
> Herbert,
> I will handle the board specific part but should the driver part go
> through the Crypto API tree?
> Will you expect that I resend the patch with Jamie's and my signatures?

Feel free to add it through your tree.

Acked-by: Herbert Xu <herbert@gondor.apana.org.au>

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
