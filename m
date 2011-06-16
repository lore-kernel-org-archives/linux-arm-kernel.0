From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 16 Jun 2011 10:57:40 -0600
Subject: [RFC PATCH 03/11] dt/irq: add irq_domain_add_simple() helper
In-Reply-To: <4DFA1160.5020208@gmail.com>
References: <20110616042653.29371.2052.stgit@ponder>
	<20110616044141.29371.76366.stgit@ponder>
	<4DFA0D83.6070604@gmail.com> <4DFA1160.5020208@gmail.com>
Message-ID: <20110616165740.GH3795@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 16, 2011 at 09:21:20AM -0500, Rob Herring wrote:
> Forgot one thing.
> 
> On 06/16/2011 09:04 AM, Rob Herring wrote:
> > Grant,
> > 
> > On 06/15/2011 11:41 PM, Grant Likely wrote:
> >> irq_domain_add_simple() is an easy way to generate an irq translation
> >> domain for simple irq controllers.  It assumes a flat 1:1 mapping from
> >> hardware irq number to an offset of the first linux irq number assigned
> >> to the controller
> >>
> 
> The description and headline are a bit out of date since adding
> irq_domain_generate_simple.

good catch.  Thanks.

g.
