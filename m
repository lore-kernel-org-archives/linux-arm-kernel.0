From: broonie@kernel.org (Mark Brown)
Date: Mon, 22 Dec 2014 13:53:01 +0000
Subject: [PATCH v3 2/5] ASoC: dwc: Iterate over all channels
In-Reply-To: <67cea1f0a74c333ec2048c7796cda37302d45e95.1418826016.git.Andrew.Jackson@arm.com>
References: <cover.1418826016.git.Andrew.Jackson@arm.com>
 <67cea1f0a74c333ec2048c7796cda37302d45e95.1418826016.git.Andrew.Jackson@arm.com>
Message-ID: <20141222135301.GQ17800@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 19, 2014 at 04:18:06PM +0000, Andrew Jackson wrote:

> The Designware core can be configured with up to four stereo channels.
> Each stereo channel is individually configured so, when the driver's
> hw_params call is made, each requested stereo channel has to be
> programmed.

This is quite unclear to someone who doesn't know the hardware, is this
a bug fix or a new feature?  It looks like it's a fix...
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141222/7e951899/attachment-0001.sig>
