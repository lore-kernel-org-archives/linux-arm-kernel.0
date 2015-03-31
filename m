From: broonie@kernel.org (Mark Brown)
Date: Tue, 31 Mar 2015 07:43:38 +0100
Subject: [PATCH 0/2] Cygnus Audio Driver
In-Reply-To: <1427771784-29950-1-git-send-email-sbranden@broadcom.com>
References: <1427771784-29950-1-git-send-email-sbranden@broadcom.com>
Message-ID: <20150331064338.GE2869@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 30, 2015 at 08:16:22PM -0700, Scott Branden wrote:

> The audio PLL is embedded in the audio block and only used
> by the audio block. The audio PLL registers are also in the middle of 
> the audio register map.

When you say it's only used by the audio block do you mean to say that
the audio block exposes no clock signals other than the bit and frame
clocks?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150331/c196a976/attachment-0001.sig>
