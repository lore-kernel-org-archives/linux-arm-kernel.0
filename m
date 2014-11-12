From: khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
Date: Wed, 12 Nov 2014 07:12:48 +0100
Subject: [PATCH v2 1/2] arm: cns3xxx: pci: remove artificial dependency on
 pci_sys_data domain
In-Reply-To: <1415287936-31203-2-git-send-email-lorenzo.pieralisi@arm.com>
 (Lorenzo Pieralisi's message of "Thu, 6 Nov 2014 15:32:13 +0000")
References: <1415287936-31203-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1415287936-31203-2-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <m38ujhgd5r.fsf@t19.piap.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> writes:

> On cns3xxx platforms the PCI controller probing code relies on an
> artificial dependency on the domain number to look-up the internal
> data structures.
>
> This patch reworks the host controller control data structure and
> adds a domain equivalent field named port in it so that the dependency on
> pci_sys_data domain field can be eventually removed.

Looks sane.
Acked-by: Krzysztof Ha?asa <khalasa@piap.pl>
-- 
Krzysztof Halasa

Research Institute for Automation and Measurements PIAP
Al. Jerozolimskie 202, 02-486 Warsaw, Poland
