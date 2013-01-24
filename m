From: florian@openwrt.org (Florian Fainelli)
Date: Thu, 24 Jan 2013 14:37:55 +0100
Subject: [RFC PATCH 6/6] ARM: kirkwood: consolidate mv643xx_eth init for DT
In-Reply-To: <ecb64cdf824399badaf9d659177811d8cb091156.1358983578.git.jason@lakedaemon.net>
References: <cover.1358983578.git.jason@lakedaemon.net>
 <ecb64cdf824399badaf9d659177811d8cb091156.1358983578.git.jason@lakedaemon.net>
Message-ID: <51013933.9020601@openwrt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Jason,

On 01/24/2013 12:34 AM, Jason Cooper wrote:
> replace a lot of unneeded code and files with a lookup table.

Would not it be better to keep all of this as-is and merge/improve Ian's 
mv643xx_eth device tree bindings [1], and then only remove these files? 
It is just 81 new lines, so it is not a big deal, just wondering here 
what is best.

[1]: http://patchwork.ozlabs.org/patch/175652/

>
> Signed-off-by: Jason Cooper <jason@lakedaemon.net>

--
Florian
