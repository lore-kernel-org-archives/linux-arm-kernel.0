From: colin.tuckley@arm.com (Colin Tuckley)
Date: Fri, 5 Mar 2010 14:25:29 -0000
Subject: [PATCH] ARM: Add Versatile Express support
In-Reply-To: <git-1267729916-61c9b6ab773870de77ff9183b8bb055a03b19671@rmk-PC>
References: <git-1267729916-9e7380877e37e33ffe507b0299aa4c6e9cac599e@rmk-PC>
	<git-1267729916-61c9b6ab773870de77ff9183b8bb055a03b19671@rmk-PC>
Message-ID: <000101cabc6f$b54b4080$1fe1c180$@tuckley@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For some reason you seem to have renamed the "System Register Interface" to
"configuration register interface"

The SRI sub-system is used for more functions than configuration and all of
the ARM documentation refers to it as the SRI, so for consistency it needs
to be called the SRI.

Colin
