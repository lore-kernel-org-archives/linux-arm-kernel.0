From: treding@nvidia.com (Thierry Reding)
Date: Tue, 25 Aug 2015 11:58:19 +0200
Subject: [PATCH v3 06/14] Documentation: drm/bridge: add document for
 analogix_dp
In-Reply-To: <1439995834-18363-1-git-send-email-ykk@rock-chips.com>
References: <1439995728-18046-1-git-send-email-ykk@rock-chips.com>
 <1439995834-18363-1-git-send-email-ykk@rock-chips.com>
Message-ID: <20150825095817.GC14034@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 19, 2015 at 09:50:34AM -0500, Yakir Yang wrote:
[...]
> +	-analogix,color-space:
> +		input video data format.
> +			COLOR_RGB = 0, COLOR_YCBCR422 = 1, COLOR_YCBCR444 = 2

I don't think DT is an appropriate place to set this. To my knowledge
this depends on the display and/or mode, so I don't think hard-coding
it here is the right thing to do.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150825/185a923a/attachment-0001.sig>
