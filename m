From: samitolvanen@google.com (Sami Tolvanen)
Date: Mon, 20 Nov 2017 12:35:49 -0800
Subject: [PATCH v2 09/18] arm64: explicitly pass
 --no-fix-cortex-a53-843419 to GNU gold
In-Reply-To: <20171120144720.bf27bpuwq4huhkdp@lakrids.cambridge.arm.com>
References: <20171115213428.22559-1-samitolvanen@google.com>
 <20171115213428.22559-10-samitolvanen@google.com>
 <20171116114722.GD9361@arm.com>
 <20171116163549.GD94341@samitolvanen.mtv.corp.google.com>
 <20171120144720.bf27bpuwq4huhkdp@lakrids.cambridge.arm.com>
Message-ID: <20171120203549.GB89108@samitolvanen.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 20, 2017 at 02:47:20PM +0000, Mark Rutland wrote:
> However, we could instead check ld-version, produce a warning, and
> abort the build in such cases.

I believe the version number of gold didn't change in binutils 2.28.1,
where this was fixed, but we could certainly warn about older versions
of gold.

Sami
