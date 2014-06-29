From: catalin.marinas@arm.com (Catalin Marinas)
Date: Sun, 29 Jun 2014 09:51:08 +0100
Subject: [PATCH 0/2] arm64: clean up /proc/cpuinfo
In-Reply-To: <20140628010440.9839.9366.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20140628010440.9839.9366.stgit@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <497A3425-6246-4E48-931B-E8992562A9A5@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Bjorn,

On 28 Jun 2014, at 02:11, Bjorn Helgaas <bhelgaas@google.com> wrote:
> Bjorn Helgaas (2):
>      arm64: add MIDR to per-CPU information
>      arm64: kernel: update cpuinfo to print all online CPUs features

Have you looked at Mark Rutland?s recent cpuinfo patches? There is
some overlap and I think they address some of your issues.

Thanks,

Catalin
