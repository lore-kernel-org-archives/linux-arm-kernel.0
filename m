From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 19 Mar 2013 16:10:06 +0000
Subject: [PATCH] arm64: Kconfig.debug: Remove unused CONFIG_DEBUG_ERRORS
In-Reply-To: <1363707697.1390.13.camel@x61.thuisdomein>
References: <1363707697.1390.13.camel@x61.thuisdomein>
Message-ID: <20130319161006.GA9321@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 19, 2013 at 03:41:37PM +0000, Paul Bolle wrote:
> The Kconfig entry for DEBUG_ERRORS is a verbatim copy of the former arm
> entry for that symbol. It got removed in v2.6.39 because it wasn't
> actually used anywhere. There are still no users of DEBUG_ERRORS so
> remove this entry too.
> 
> Signed-off-by: Paul Bolle <pebolle@tiscali.nl>

Thanks, applied.

-- 
Catalin
