From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 23 Apr 2014 14:39:26 +0200
Subject: [PATCH v6 6/8] ARM: sun6i: Sort the NMI node by physical address
In-Reply-To: <1397724379-15398-7-git-send-email-maxime.ripard@free-electrons.com>
References: <1397724379-15398-1-git-send-email-maxime.ripard@free-electrons.com>
 <1397724379-15398-7-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <201404231439.26549.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 17 April 2014, Maxime Ripard wrote:
> The DT are supposed to be ordered by physical address. Move the NMI node where
> it belongs.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
