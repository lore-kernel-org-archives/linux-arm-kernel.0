From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 10 Nov 2014 14:02:28 +0000
Subject: [PATCH] ARM: Wire up bpf syscall
In-Reply-To: <1415627996-27395-1-git-send-email-thierry.reding@gmail.com>
References: <1415627996-27395-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <20141110140228.GX4042@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 10, 2014 at 02:59:56PM +0100, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Add the bpf syscall to ARM.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
> Note that I haven't tested whether this new syscall actually works on ARM,
> but it certainly gets rid of the annoying "syscall bpf not implemented"
> warning.

I guess you're using an old kernel... the commit adding this is already
merged - v3.18-rc3~4^2~4

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
