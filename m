From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 13 Feb 2014 19:40:09 +0000
Subject: [PATCH] drm/i2c: tda998x: fix memory leak in case of i2c error
In-Reply-To: <20140213083316.38D7D822BD@smtp6-g21.free.fr>
References: <20140213083316.38D7D822BD@smtp6-g21.free.fr>
Message-ID: <20140213194009.GD30257@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 13, 2014 at 09:13:34AM +0100, Jean-Francois Moine wrote:
> When the creation of the second i2c client was failing, the private
> buffer was not freed.
> 
> This bug was introduced by the commit 6ae668cc19e8
> 'drm/i2c: tda998x: check the CEC device creation'
> 
> Signed-off-by: Jean-Francois Moine <moinejf@free.fr>

Since David got there first with his patch, which is identical to yours,
I'll take his description, and take this as an acked-by for it.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
