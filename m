From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 28 Jan 2015 15:18:29 +0100
Subject: [PATCH] drm: msm: add missing dependencies on OF and COMMON_CLK
In-Reply-To: <1422452889-415782-6-git-send-email-arnd@arndb.de>
References: <1422452889-415782-1-git-send-email-arnd@arndb.de>
 <1422452889-415782-6-git-send-email-arnd@arndb.de>
Message-ID: <1733616.Vvg47GPXix@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 28 January 2015 14:48:09 Arnd Bergmann wrote:
> The msm gpu drivers depend on both the DT mechanism and the
> common clk handling code, if they are not enabled, we get
> ...

As should be obvious, this one was meant to be [PATCH 5/5], but
I messed up the subject line.

	Arnd
