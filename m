From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Tue, 30 Jul 2013 00:26:17 +0200
Subject: Defining schemas for Device Tree
In-Reply-To: <20130729181550.GD15861@obsidianresearch.com>
References: <2469263.vMN09Q7Tzi@flatron>
 <20130729181550.GD15861@obsidianresearch.com>
Message-ID: <2616428.Qqf6nluuzC@thinkpad>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 29 of July 2013 12:15:50 Jason Gunthorpe wrote:
> On Mon, Jul 29, 2013 at 02:21:52AM +0200, Tomasz Figa wrote:
> > e) What format should be used for Device Tree schema?
> > 
> > This is a non-trivial problem. Key criteria I can think of are as
> 
> > follows:
> You may wish to think about this as a linter+checker (like
> sparse/coverity, etc) and code the 'schema' in C code.
> 
> As you've noticed already there are many complex cases. Look at the
> PCI bindings, for instance, the complexity of what needs to be valided
> is very high.

This sounds like an interesting idea. Not sure about usability of such schemas 
as human-readable documentation, though.

Best regards,
Tomasz
