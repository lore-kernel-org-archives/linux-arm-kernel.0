From: jcm@redhat.com (Jon Masters)
Date: Thu, 15 Feb 2018 15:59:29 -0500
Subject: [PATCH v4 00/17] arm64: Add SMCCC v1.1 support and CVE-2017-5715
 (Spectre variant 2) mitigation
In-Reply-To: <20180206175621.929-1-marc.zyngier@arm.com>
References: <20180206175621.929-1-marc.zyngier@arm.com>
Message-ID: <e9df17e7-86ee-2f7a-b8e2-d78ac0358fc3@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc, all,

On 02/06/2018 12:56 PM, Marc Zyngier wrote:
> ARM has recently published a SMC Calling Convention (SMCCC)
> specification update[1] that provides an optimised calling convention
> and optional, discoverable support for mitigating CVE-2017-5715. ARM
> Trusted Firmware (ATF) has already gained such an implementation[2].

I'm probably just missing something, but does this end up reported
somewhere conveniently user visible? In particular, if the new SMC is
*not* provided, does the user end up easily seeing this?

Jon.

-- 
Computer Architect | Sent from my Fedora powered laptop
