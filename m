From: joe@perches.com (Joe Perches)
Date: Tue, 15 Nov 2011 16:57:29 -0800
Subject: [PATCH 4/4] mmc: Add mmc_host_<level> logging
In-Reply-To: <CAKYAXd_wtGVQYgr_MUtVGGpkpqJgF56bfm0zO-nnAK0YpkT+bg@mail.gmail.com>
References: <cover.1321398814.git.joe@perches.com>
 <631c53d126feff0a99b61d9c9a00b308d2b638ee.1321398815.git.joe@perches.com>
 <CAKYAXd_wtGVQYgr_MUtVGGpkpqJgF56bfm0zO-nnAK0YpkT+bg@mail.gmail.com>
Message-ID: <1321405049.21286.35.camel@Joe-Laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-11-16 at 09:52 +0900, NamJae Jeon wrote:
> 2011/11/16 Joe Perches <joe@perches.com>:
> > Centralize the pr_<level> uses of mmc_hostname into specific
> > mmc_host_<level> calls to allow a flexible presentation style
> > and shorten the code a bit.

> I don't know why pr_info should be surely replaced by mmc_host_info.
> if it is needed for only host name, I think that existing
> pr_info/err/debug is sufficient.

Please trim your replies and read the patch description.
