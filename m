From: johannes@sipsolutions.net (Johannes Berg)
Date: Tue, 25 Feb 2014 16:15:42 +0100
Subject: [PATCHv2 1/5] ARM: tegra: remove obsolete gpio entries
In-Reply-To: <1393330950-7283-2-git-send-email-heikki.krogerus@linux.intel.com>
References: <1393330950-7283-1-git-send-email-heikki.krogerus@linux.intel.com>
 <1393330950-7283-2-git-send-email-heikki.krogerus@linux.intel.com>
Message-ID: <1393341342.4170.9.camel@jlt4.sipsolutions.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2014-02-25 at 14:22 +0200, Heikki Krogerus wrote:
> After moving to description based gpio interface in
> rfkill-gpio, the gpio numbers are not used any more.
> 
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
>  arch/arm/mach-tegra/board-paz00.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Hm, ok, I'm not sure I should take a tegra patch through the mac80211 ->
wireless -> networking trees. OTOH, I suppose that the second patch
depends on this. I can take it all I suppose, Thierry? Stephen?

johannes
