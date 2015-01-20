From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 20 Jan 2015 16:24:30 +0000
Subject: [GIT PULL] ARM kprobe updates
In-Reply-To: <1421746999.4328.3.camel@linaro.org>
References: <1421746999.4328.3.camel@linaro.org>
Message-ID: <20150120162430.GK26493@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 20, 2015 at 09:43:19AM +0000, Jon Medhurst (Tixy) wrote:
> Hi Russell
> 
> Please consider pulling the following changes to ARM kprobes.
> 
> This consists of Wang Nan's implementation of optimized kprobes on ARM,
> which use branch instructions to call the handler rather than using
> undefined instructions as breakpoints. It also contains various fixes
> and extensions to the test code which were discovered along the way.
> 
> The patch from Masami Hiramatsu is outside of arch/arm but as kprobes
> maintainer he indicated that it was OK for this simple patch to go
> through the ARM tree, if you are also amenable. (See
> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-January/317948.html)
> 
> Thanks
> 
> 
> The following changes since commit b1940cd21c0f4abdce101253e860feff547291b0:
> 
>   Linux 3.19-rc3 (2015-01-05 17:05:20 -0800)
> 
> are available in the git repository at:
> 
>   git://git.linaro.org/people/tixy/kernel.git kprobes

Thanks, pulled, though it'll probably be two or so days before it
shows up in linux-next.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
