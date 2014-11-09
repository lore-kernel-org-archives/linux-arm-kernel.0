From: sre@kernel.org (Sebastian Reichel)
Date: Sun, 9 Nov 2014 13:40:25 +0100
Subject: tsc2005 touchscreen: implement disable attribute
In-Reply-To: <20141109115636.GA3106@amd>
References: <20141109115636.GA3106@amd>
Message-ID: <20141109124025.GA21763@earth.universe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, Nov 09, 2014 at 12:56:37PM +0100, Pavel Machek wrote:
> Implement disable attribute for tsc2005 touchscreen. It is useful to
> avoid wakeups when phone is in the pocket.

I don't think this should be some driver specific sysfs node.
Instead a generic method from the input subsystem should be
used.

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141109/f6b2e45d/attachment.sig>
