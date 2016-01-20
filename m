From: geoff@infradead.org (Geoff Levand)
Date: Tue, 19 Jan 2016 16:15:00 -0800
Subject: [PATCH 00/19] arm64 kexec kernel patches v13
In-Reply-To: <20160119123230.GB2904@dhcp-128-65.nay.redhat.com>
References: <cover.1452884156.git.geoff@infradead.org>
 <20160119123230.GB2904@dhcp-128-65.nay.redhat.com>
Message-ID: <1453248900.21755.8.camel@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2016-01-19 at 20:32 +0800, Dave Young wrote:
> Geoff, another question about kexec-tools part is, can the kexec
> -tools code
> been written in kernel? We have the infrastructure for kexec_file_load.

I see no technical reason why the arm64 kernel cannot support
kexec_file_load.

-Geoff
