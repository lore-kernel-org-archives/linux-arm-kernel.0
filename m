From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 02 Dec 2015 16:10:58 +0100
Subject: [PATCH 1/5] ARM: config: Regenerate multi_v5_defconfig
In-Reply-To: <20151202150801.GL29814@lunn.ch>
References: <1449012812-9779-1-git-send-email-andrew@lunn.ch>
 <2115626.l90A97hBkH@wuerfel> <20151202150801.GL29814@lunn.ch>
Message-ID: <1799595.aerWlahiX8@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 02 December 2015 16:08:01 Andrew Lunn wrote:
> 
> Humm, i wounder if 0-day could be of use here. How about at the end of
> each patch series, it regenerates the _defconfig files. If there are
> any changes, issue a warning. That will help keep them in sync with
> reality.

Sounds like a good idea, but it will have to regenerate the defconfig files
before and after and see if there are additional changes.

	Arnd
