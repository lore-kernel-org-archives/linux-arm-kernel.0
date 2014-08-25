From: pavel@denx.de (Pavel Machek)
Date: Mon, 25 Aug 2014 13:21:51 +0200
Subject: [PATCHv10 0/5] ARM: remove the sub-node and deprecate
 supports-highspeed property for dwmmc.
In-Reply-To: <1407397082-32495-1-git-send-email-jh80.chung@samsung.com>
References: <1407397082-32495-1-git-send-email-jh80.chung@samsung.com>
Message-ID: <20140825112151.GA21336@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu 2014-08-07 16:37:57, Jaehoon Chung wrote:
> Since used the mmc_of_parse(), didn't parse the sub-node.
> So we can remove the sub-node, because almost SoC used the only one card per a host.
> And supports-highspeed can be replaced with "cap-mmc/sd-highspeed"
>property.

Would it be better to fix parsing of the device tree, and not to
change all the device trees?

Someone will want to do two slots sooner or later...

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
