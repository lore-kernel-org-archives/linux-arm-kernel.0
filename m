From: rkrcmar@redhat.com (Radim =?utf-8?B?S3LEjW3DocWZ?=)
Date: Fri, 22 Jun 2018 16:33:08 +0200
Subject: [GIT PULL] KVM/arm updates for 4.18-rc2
In-Reply-To: <20180622124953.12355-1-marc.zyngier@arm.com>
References: <20180622124953.12355-1-marc.zyngier@arm.com>
Message-ID: <20180622143307.GA2377@flask>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2018-06-22 13:49+0100, Marc Zyngier:
> Radim, Paolo,
> 
> This is the first batch of fixes for 4.18, mostly dealing with the
> fallout from Dave's lazy FPSIMD handling. We also have the disabling
> of the compat interface on arm64 (it never had it the first place),
> and a relaxation on the alignment of the GICv3 compatibility
> interface.
> 
> Please pull.

Pulled, thanks.
