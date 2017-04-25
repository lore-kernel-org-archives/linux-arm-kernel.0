From: joe@perches.com (Joe Perches)
Date: Tue, 25 Apr 2017 12:21:51 -0700
Subject: [PATCH] PCI: imx6: fix spelling mistake: "contol" -> "control"
In-Reply-To: <20170425190429.GA29024@bhelgaas-glaptop.roam.corp.google.com>
References: <20170421070230.16582-1-colin.king@canonical.com>
 <20170425190429.GA29024@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <1493148111.18659.5.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2017-04-25 at 14:04 -0500, Bjorn Helgaas wrote:
> On Fri, Apr 21, 2017 at 08:02:30AM +0100, Colin King wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> > 
> > trivial fix to spelling mistake in dev_err message
> > 
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> 
> Applied with Richard's ack to pci/host-imx6 for v4.12, thanks.
> 
> FWIW, there are about 25 other occurrences of "contol" in other parts
> of the tree.

Colin seems to focus on the logging format strings and
not code comments.

Other than these 2, there are 28 other instances in -next.
All of them are not output anywhere, these are just source
code comments.

$ git grep -w -i -E "contoller|contol" | wc -l
30
