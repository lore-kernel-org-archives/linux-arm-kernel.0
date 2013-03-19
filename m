From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 19 Mar 2013 15:45:58 +0000
Subject: [PATCH] arm64: Do not select GENERIC_HARDIRQS_NO_DEPRECATED
In-Reply-To: <1362516222.16460.121.camel@x61.thuisdomein>
References: <1362516222.16460.121.camel@x61.thuisdomein>
Message-ID: <20130319154558.GD507@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 05, 2013 at 08:43:42PM +0000, Paul Bolle wrote:
> Config option GENERIC_HARDIRQS_NO_DEPRECATED was removed in commit
> 78c89825649a9a5ed526c507603196f467d781a5 ("genirq: Remove the now obsolete
> config options and select statements"), but the select was accidentally
> reintroduced in commit 8c2c3df31e3b87cb5348e48776c366ebd1dc5a7a ("arm64:
> Build infrastructure").
> 
> Signed-off-by: Paul Bolle <pebolle@tiscali.nl>

Applied, thanks (it will appear in mainline at some point).

-- 
Catalin
