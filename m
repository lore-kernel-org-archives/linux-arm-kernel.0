From: joe@perches.com (Joe Perches)
Date: Mon, 15 Sep 2014 09:02:12 -0700
Subject: [PATCH 1/8] arm: Convert pr_warning to pr_warn
In-Reply-To: <20140915155656.GA29744@arm.com>
References: <cover.1410632834.git.joe@perches.com>
 <7995478e8c658478cd37dabb996f7269405251ac.1410632835.git.joe@perches.com>
 <20140915155656.GA29744@arm.com>
Message-ID: <1410796932.18787.7.camel@joe-AO725>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2014-09-15 at 16:56 +0100, Will Deacon wrote:
> On Sat, Sep 13, 2014 at 07:31:12PM +0100, Joe Perches wrote:
> > Use the more common pr_warn.
[]
> It's Russell's call on this, but it really looks like more trouble than it's
> worth imo. Having git blame identify the person who wrote the original code
> is considerably more useful than being pointed at somebody making cosmetic
> changes.

The general idea is to standardize the printk mechanisms
and eventually remove pr_warning.
