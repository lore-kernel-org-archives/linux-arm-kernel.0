From: horms@verge.net.au (Simon Horman)
Date: Fri, 7 Mar 2014 11:38:32 +0900
Subject: [PATCH] ARM: shmobile: Make use of r8a7790_add_standard_devices()
In-Reply-To: <20140224054907.1803.88038.sendpatchset@w520>
References: <20140224054907.1803.88038.sendpatchset@w520>
Message-ID: <20140307023829.GI11702@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 24, 2014 at 02:49:07PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Move non-PFC and non-GPIO devices off from r8a7790_pinmux_init()
> and into r8a7790_add_standard_devices() which is the normal place
> to keep regular devices in the legacy case.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

Thanks, I have queued this up.
