From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 6 Jun 2013 14:20:03 -0400
Subject: [PATCH] ARM: Kirkwood: handle mv88f6282 cpu in
 __kirkwood_variant().
In-Reply-To: <1370538046-1186-1-git-send-email-nschichan@freebox.fr>
References: <1370538046-1186-1-git-send-email-nschichan@freebox.fr>
Message-ID: <20130606182003.GO23859@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 06, 2013 at 07:00:46PM +0200, Nicolas Schichan wrote:
> MPP_F6281_MASK would be previously be returned when on mv88f6282,
> which would disallow some valid MPP configurations.
> 
> Commit 830f8b91 (arm: plat-orion: fix printing of "MPP config
> unavailable on this hardware") made this problem visible as an invalid
> MPP configuration is now correctly detected and not applied.
> 
> Signed-off-by: Nicolas Schichan <nschichan@freebox.fr>
> ---
>  arch/arm/mach-kirkwood/mpp.c |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Applied to mvebu/fixes with Cc: to -stable for v3.9 and newer.

thx,

Jason.
