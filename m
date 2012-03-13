From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 13 Mar 2012 09:57:26 +0000
Subject: [PATCH 6/7] ARM: kirkwood: rtc-mv devicetree bindings
In-Reply-To: <0b9921e304cb46af9c4fbc8b7b8c8b9ba3d18654.1331601448.git.jason@lakedaemon.net>
References: <cover.1331601448.git.jason@lakedaemon.net>
 <0b9921e304cb46af9c4fbc8b7b8c8b9ba3d18654.1331601448.git.jason@lakedaemon.net>
Message-ID: <201203130957.26274.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 13 March 2012, Jason Cooper wrote:
> Signed-off-by: Jason Cooper <jason@lakedaemon.net>
> ---
>  drivers/rtc/rtc-mv.c |    9 +++++++++
>  1 files changed, 9 insertions(+), 0 deletions(-)

Acked-by: Arnd Bergmann <arnd@arndb.de>

It would be nice to have a small patch description here, saying that
this device is trivial to convert to device tree by just adding the
match table.

	Arnd
