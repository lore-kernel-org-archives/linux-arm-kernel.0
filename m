From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 15 Aug 2012 16:16:56 +0000
Subject: [PATCH v2 27/31] arm64: Loadable modules
In-Reply-To: <20120815153538.GA14264@arm.com>
References: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com>
 <201208151523.21447.arnd@arndb.de> <20120815153538.GA14264@arm.com>
Message-ID: <201208151616.56932.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 15 August 2012, Catalin Marinas wrote:
> Primarily branch relocation, we have a limitation to 128MB branch range.
> The alternative would be to always compile the modules with a large
> memory model but we may lose some performance and could make the
> relocation handling even harder. What we do now is pretty much similar
> to static linking but at module load time.

Ok, makes sense.

	Arnd
