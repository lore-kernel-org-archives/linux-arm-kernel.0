From: der.herr@hofr.at (Nicholas Mc Guire)
Date: Sat, 11 Feb 2017 10:15:43 +0000
Subject: [PATCH] crypto: arm/aes-ce: assign err return conditionally
In-Reply-To: <20170211093946.GA749@gondor.apana.org.au>
References: <1486560979-25240-1-git-send-email-der.herr@hofr.at>
 <20170211093946.GA749@gondor.apana.org.au>
Message-ID: <20170211101543.GC13432@osadl.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 11, 2017 at 05:39:46PM +0800, Herbert Xu wrote:
> On Wed, Feb 08, 2017 at 02:36:19PM +0100, Nicholas Mc Guire wrote:
> > As the err value is not used unless there was an error it can be assigned
> > conditionally here. 
> > 
> > Signed-off-by: Nicholas Mc Guire <der.herr@hofr.at>
> 
> This patch just adds noise to the commit history.  So I'm not going
> to apply it.

ok - I was not sure about how sensible this sort of changes are
either - will drop those code-to-object refactoring experiments
then again.

thx!
hofrat
