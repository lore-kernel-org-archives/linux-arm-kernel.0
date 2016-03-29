From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Tue, 29 Mar 2016 14:12:09 +0100
Subject: [RFC PATCH 00/45] KVM: arm/arm64: Rework virtual GIC emulation
In-Reply-To: <1458871508-17279-1-git-send-email-andre.przywara@arm.com>
References: <1458871508-17279-1-git-send-email-andre.przywara@arm.com>
Message-ID: <56FA7F29.4060005@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andre,

On 25/03/16 02:04, Andre Przywara wrote:
> Please have a look at the series, review it and give the code some
> serious testing (and possibly debugging). All feedback is appreciated.

I see that with the new vgic implementation kvmtool starts throwing:

kvm [1273]: Unable to register VGICv3 redist MMIO regions

for --cpus 58 and above, where with the old vgic it is quite happy with
up to 255 cpus.

Cheers
Vladimir
