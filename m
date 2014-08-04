From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 4 Aug 2014 17:18:21 +0200
Subject: [PATCH v3] arm64: fix VTTBR_BADDR_MASK
In-Reply-To: <53DF9BE6.2090701@amd.com>
References: <20140804143845.2851.85441.stgit@joelaarch64.amd.com>
 <53DF9BE6.2090701@amd.com>
Message-ID: <20140804151821.GB1774@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 04, 2014 at 09:42:46AM -0500, Joel Schopp wrote:
> Since this fixes a real problem and didn't make it into 3.16 it would be
> good if this made it into 3.17.
> 
It's too late for the merge window, we have to review and test as I told
you in a private e-mail.

We will review this and test it, and if it makes sense merge as a fix
for 3.17 before the release.

Please be a little patient given the number of patches on the list
currently.

Thanks,
-Christoffer
