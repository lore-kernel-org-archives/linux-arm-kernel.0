From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 29 Jul 2014 14:52:40 +0200
Subject: [PATCH 19/19] Documentation: ACPI for ARM64
In-Reply-To: <CAMJs5B_Ye1eXsvJAKWnHRxC4jnpcXMcqHE+GgOGO7MHtPcsSQA@mail.gmail.com>
References: <1406206825-15590-1-git-send-email-hanjun.guo@linaro.org>
 <20140729112824.GM2576@leverpostej>
 <CAMJs5B_Ye1eXsvJAKWnHRxC4jnpcXMcqHE+GgOGO7MHtPcsSQA@mail.gmail.com>
Message-ID: <351673188.FxXsM7MvdA@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 29 July 2014 14:37:38 Christoffer Dall wrote:
> 
> For reference, Red Hat's current arguing point for ACPI in VMs is
> hotplug of things like CPUs and memory for very large VMs, but I
> haven't thought too carefully about this just yet, as I don't have a
> 100+ core ARM 64-bit hardware lying around...

I thought you could run guests with more virtual CPUs that you have
physical CPUs on the host.

Regarding CPU and memory hotplug, don't we already have PSCI and
xen-balloon/virtio-balloon for that?

	Arnd
