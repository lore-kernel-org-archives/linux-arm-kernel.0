From: hch@lst.de (Christoph Hellwig)
Date: Wed, 16 May 2018 19:34:45 +0200
Subject: [PATCH 14/14] mm: turn on vm_fault_t type checking
In-Reply-To: <20180516150829.GA4904@magnolia>
References: <20180516054348.15950-1-hch@lst.de>
 <20180516054348.15950-15-hch@lst.de> <20180516150829.GA4904@magnolia>
Message-ID: <20180516173445.GA6088@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 16, 2018 at 08:08:29AM -0700, Darrick J. Wong wrote:
> Uh, we're changing function signatures /and/ redefinining vm_fault_t?
> All in the same 90K patch?
> 
> I /was/ expecting a series of "convert XXXXX and all callers/users"
> patches followed by a trivial one to switch the definition, not a giant
> pile of change.  FWIW I don't mind so much if you make a patch
> containing a change for some super-common primitive and a hojillion
> little diff hunks tree-wide, but only one logical change at a time for a
> big patch, please...
> 
> I quite prefer seeing the whole series from start to finish all packaged
> up in one series, but wow this was overwhelming. :/

Another vote to split the change of the typedef, ok I get the message..
