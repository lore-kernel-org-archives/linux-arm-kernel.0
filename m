From: broonie@kernel.org (Mark Brown)
Date: Tue, 4 Mar 2014 15:47:52 +0800
Subject: [PATCH] arm64: topology: Implement basic CPU topology support
In-Reply-To: <1393916911-15571-1-git-send-email-broonie@kernel.org>
References: <1393916911-15571-1-git-send-email-broonie@kernel.org>
Message-ID: <20140304074752.GF13126@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 04, 2014 at 03:08:31PM +0800, Mark Brown wrote:
> From: Mark Brown <broonie@linaro.org>
> 
> Add basic CPU topology support to arm64, based on the existing pre-v8
> code and some work done by Mark Hambleton.  This patch does not
> implement any topology discovery support since that should be based on
> information from firmware, it merely implements the scaffolding for
> integration of topology support in the architecture.

Sorry, needs a respin due to me failing to rebase down the right
pr_macro - new version shortly.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140304/010d7829/attachment.sig>
