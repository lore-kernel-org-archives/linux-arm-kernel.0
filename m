From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 20 Jan 2017 08:09:28 +0100
Subject: [PATCH 2/2] Input: tca8418 - switch to using generic device
 properties
In-Reply-To: <20170119224803.10713-2-dmitry.torokhov@gmail.com>
References: <20170119224803.10713-1-dmitry.torokhov@gmail.com>
 <20170119224803.10713-2-dmitry.torokhov@gmail.com>
Message-ID: <20170120070928.7ciuuw7jwhxorqlb@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 19, 2017 at 02:48:03PM -0800, Dmitry Torokhov wrote:
> Let's drop legacy platform data support (there are no users in mainline)
> and switch to using generic device properties, which will make the driver
> simpler (non-OF boards can use property sets to describe hardware).
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Reviewed-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170120/b15164af/attachment.sig>
