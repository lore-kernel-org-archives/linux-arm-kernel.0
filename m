From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 1 Nov 2013 10:13:17 +0100
Subject: [PATCH] clk: Do not dereference potential NULL pointer
In-Reply-To: <20131031182233.11662.77737@quantum>
References: <1383221036-26890-1-git-send-email-treding@nvidia.com>
 <20131031182233.11662.77737@quantum>
Message-ID: <20131101091316.GC27864@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 31, 2013 at 11:22:33AM -0700, Mike Turquette wrote:
> Quoting Thierry Reding (2013-10-31 05:03:56)
> > A NULL pointer may be passed to _clk_register() for the dev parameter
> > (via clk_register()). Make sure not to dereference it before checking
> > that it's valid.
> > 
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
> 
> Hi Thierry,
> 
> I saw Olof's fix first so I took that and applied your Ack.

Perhaps we need a new kind of tag. Something like Also-by: =)

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131101/b86181ce/attachment.sig>
