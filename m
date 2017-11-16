From: will.deacon@arm.com (Will Deacon)
Date: Thu, 16 Nov 2017 11:46:17 +0000
Subject: [PATCH v2 06/18] arm64: kvm: use -fno-jump-tables with clang
In-Reply-To: <20171115213428.22559-7-samitolvanen@google.com>
References: <20171115213428.22559-1-samitolvanen@google.com>
 <20171115213428.22559-7-samitolvanen@google.com>
Message-ID: <20171116114616.GC9361@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 15, 2017 at 01:34:16PM -0800, Sami Tolvanen wrote:
> Use -fno-jump-tables to make sure clang doesn't generate branches
> to EL1 virtual addresses.

Can you elaborate a bit more on exactly what you saw failing here, please?
Whilst it's obviously broken to jump to EL1 from EL2 w/o VHE, the commit
message is a bit cryptic.

Will
