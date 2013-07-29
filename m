From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Mon, 29 Jul 2013 12:15:50 -0600
Subject: Defining schemas for Device Tree
In-Reply-To: <2469263.vMN09Q7Tzi@flatron>
References: <2469263.vMN09Q7Tzi@flatron>
Message-ID: <20130729181550.GD15861@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 29, 2013 at 02:21:52AM +0200, Tomasz Figa wrote:
 
> e) What format should be used for Device Tree schema?
> 
> This is a non-trivial problem. Key criteria I can think of are as
> follows:

You may wish to think about this as a linter+checker (like
sparse/coverity, etc) and code the 'schema' in C code.

As you've noticed already there are many complex cases. Look at the
PCI bindings, for instance, the complexity of what needs to be valided
is very high.

Jason
