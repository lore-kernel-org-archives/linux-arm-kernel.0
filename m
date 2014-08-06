From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 6 Aug 2014 19:53:13 +0200
Subject: [RFC 0/8] DPCM with simple-card support for Kirkwood
In-Reply-To: <20140806194304.3a1867a8@armhf>
References: <1407287912-19447-1-git-send-email-andrew@lunn.ch>
 <20140806103356.4e7c088a@armhf> <20140806143026.GA19574@lunn.ch>
 <20140806194304.3a1867a8@armhf>
Message-ID: <20140806175313.GC19574@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 06, 2014 at 07:43:04PM +0200, Jean-Francois Moine wrote:
> On Wed, 6 Aug 2014 16:30:26 +0200
> Andrew Lunn <andrew@lunn.ch> wrote:
> 
> > At the moment, i'm not so interested in details, but more about, is
> > this the right direction to allow Russell to progress. Once i know
> > that, we can work on details.
> 
> These are not details. Putting DPCM in the Cubox is easy (I may send
> you my work which seems simpler), but there is no way to make it work
> correctly, and that's why I forgot about it.

Does it not work correctly because of a property of the hardware, or
because of bugs in the DPCM implementation? From what you pointed out
in the mailing lists, it seems like bugs.

   Thanks
	Andrew
