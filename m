From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 22 May 2014 19:52:06 +0200
Subject: [PATCH v3 5/9] ASoC: simple-card: Support setting mclk via a
 fixed factor
In-Reply-To: <20140522173919.GM12304@sirena.org.uk>
References: <20140520221359.GF12304@sirena.org.uk>
 <1400772710-23523-1-git-send-email-andrew@lunn.ch>
 <20140522173919.GM12304@sirena.org.uk>
Message-ID: <20140522175206.GA24500@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 22, 2014 at 06:39:19PM +0100, Mark Brown wrote:
> On Thu, May 22, 2014 at 05:31:49PM +0200, Andrew Lunn wrote:
> > Some platforms require that the codecs mclk is a fixed multiplication
> > factor of the audio stream rate. Add a optional property to the
> > binding to hold this factor and implement a hw_params() function to
> > make use of it.
> > 
> > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> 
> I'm missing the rest of this series - what's the context, are there any
> interdependencies?

I threaded the patch to your request to respin this patch:

http://patchwork.ozlabs.org/patch/345353/

and the whole the v2 series is here:

http://www.spinics.net/linux/lists/arm-kernel/msg328068.html

You have already accepted patch 1, and Jason Cooper has taken 2, 3, 4,
6, 7, 8, & 9.

There are no build interdependences.

      Andrew
