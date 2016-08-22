From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 22 Aug 2016 12:49:03 -0600
Subject: [PATCH v3 04/12] firmware: tegra: Add IVC library
In-Reply-To: <20160819173233.13260-5-thierry.reding@gmail.com>
References: <20160819173233.13260-1-thierry.reding@gmail.com>
 <20160819173233.13260-5-thierry.reding@gmail.com>
Message-ID: <a11ba4fb-5be5-7b26-164d-63831d8891c7@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/19/2016 11:32 AM, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
>
> The Inter-VM communication (IVC) is a communication protocol which is
> designed for interprocessor communication (IPC) or the communication
> between the hypervisor and the virtual machine with a guest OS.
>
> Message channels are used to communicate between processors. They are
> backed by DRAM or SRAM, so care must be taken to maintain coherence of
> data.
>
> The IVC library maintains memory-based descriptors for the transmission
> and reception channels as well as the data coherence of the counter and
> payload. Clients, such as the driver for the BPMP firmware, can use the
> library to exchange messages with remote processors.
>
> Based on work by Peter Newman <pnewman@nvidia.com> and Joseph Lo
> <josephl@nvidia.com>.

Reviewed-by: Stephen Warren <swarren@nvidia.com>

All the renaming/restructuring relative to the internal code made 
comparing them a bit more difficult that I'd like...
