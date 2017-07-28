From: broonie@kernel.org (Mark Brown)
Date: Fri, 28 Jul 2017 13:46:34 +0100
Subject: [PATCH] ASoC: Intel: Reset hw_ptr on resume trigger
In-Reply-To: <20170728084206.4431-1-cychiang@chromium.org>
References: <20170728084206.4431-1-cychiang@chromium.org>
Message-ID: <20170728124634.ajonhi3cdbb35qeb@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 28, 2017 at 04:42:06PM +0800, Cheng-Yi Chiang wrote:
> From: "U. Artie Eoff" <ullysses.a.eoff@intel.com>
> 
> Reset the hw_ptr before queuing the restore_stream_context
> work to eradicate a nasty white audio noise on resume.
> 
> Signed-off-by: U. Artie Eoff <ullysses.a.eoff@intel.com>

I can't do anything with this, you've not provided a signoff for it.
Please see SubmittingPatches for what a signoff means and why it's
important.

Please also try to send your patches to relevant people - you've sent
this to the ARM kernel list but not to Vinod Koul who's the main
maintainer for the Intel drivers.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170728/d6f67b24/attachment.sig>
