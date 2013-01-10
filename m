From: horms@verge.net.au (Simon Horman)
Date: Thu, 10 Jan 2013 09:46:19 +0900
Subject: [PATCH v2 2/2] ARM: SH-Mobile: sh73a0: Add CPU Hotplug
In-Reply-To: <1357760512-2634-2-git-send-email-hechtb+renesas@gmail.com>
References: <1357760512-2634-1-git-send-email-hechtb+renesas@gmail.com>
 <1357760512-2634-2-git-send-email-hechtb+renesas@gmail.com>
Message-ID: <20130110004618.GB29988@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 09, 2013 at 08:41:52PM +0100, Bastian Hecht wrote:
> Add the capability to add and remove CPUs on the fly.
> The Cortex-A9 offers the possibility to take single cores out of the
> MP Core. We add this capabilty taking care that caches are kept
> coherent. For verifying the shutdown we rely on the internal SH73A0
> Power Status Register PSTR.
> 
> Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>

Thanks, applied to the soc2 branch.
