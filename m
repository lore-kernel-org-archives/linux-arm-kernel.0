From: tn@semihalf.com (Tomasz Nowicki)
Date: Fri, 9 Sep 2016 21:30:49 +0200
Subject: [PATCH V6 0/5] ECAM quirks handling for ARM64 platforms
In-Reply-To: <1473449047-10499-1-git-send-email-tn@semihalf.com>
References: <1473449047-10499-1-git-send-email-tn@semihalf.com>
Message-ID: <9a7047d4-04bd-cb89-dc37-8404d7b91bb8@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09.09.2016 21:24, Tomasz Nowicki wrote:
> Quirk handling relies on an idea of simple static array which contains
> quirk enties. Each entry consists of identification information (IDs from
> standard header of MCFG table) along with custom pci_ecam_ops structure and
> configuration space resource structure. This way it is possible find
> corresponding quirk entries and override pci_ecam_ops and PCI configuration
> space regions.
>
> As an example, the last 3 patches present quirk handling mechanism usage for
> ThunderX.
>

This series can be found here:
git at github.com:semihalf-nowicki-tomasz/linux.git (branch: pci-acpi-quirk-v6)

Thanks,
Tomasz
