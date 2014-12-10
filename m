From: broonie@kernel.org (Mark Brown)
Date: Wed, 10 Dec 2014 16:07:20 +0000
Subject: [RFC 04/15] regulator: add restrack support
In-Reply-To: <1418226513-14105-5-git-send-email-a.hajda@samsung.com>
References: <1418226513-14105-1-git-send-email-a.hajda@samsung.com>
 <1418226513-14105-5-git-send-email-a.hajda@samsung.com>
Message-ID: <20141210160720.GS11764@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 10, 2014 at 04:48:22PM +0100, Andrzej Hajda wrote:
> Regulators supports various methods of lookup.
> The patch adds restrack support only to DT based regulators.

Why, what does this mean and how might one use it?  I've not looked at
the code since I don't know what it's supposed to accomplish...

One very high level thing is that anything that only works for DT only
seems to be a non-starter, the API should be hiding details of the
firmware interface.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141210/2edabc3e/attachment.sig>
