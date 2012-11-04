From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 4 Nov 2012 09:55:56 +0000
Subject: [PATCH] ARM: quiet down the non make -s output
In-Reply-To: <20121029153425.GA9486@beefymiracle.amer.corp.natinst.com>
References: <20121029153425.GA9486@beefymiracle.amer.corp.natinst.com>
Message-ID: <20121104095556.GX21164@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 29, 2012 at 09:34:25AM -0600, Josh Cartwright wrote:
> Commit edc88ceb0c7d285b9f58bc29a638cd8163b59989 silenced the make -s build, but
> inadvertently made louder the non-silent build.  Fix by prepending '@' to each
> of the added $(kecho) statements.

Please put this in the patch system, thanks.
