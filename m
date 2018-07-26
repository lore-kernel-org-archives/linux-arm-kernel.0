From: balbi@kernel.org (Felipe Balbi)
Date: Thu, 26 Jul 2018 14:10:07 +0300
Subject: [PATCH v6 4/4] arm: arm64: dts: add property snps incr burst type
 adjustment
In-Reply-To: <1532341959-3478-4-git-send-email-pengbo.mu@nxp.com>
References: <1532341959-3478-1-git-send-email-pengbo.mu@nxp.com>
 <1532341959-3478-4-git-send-email-pengbo.mu@nxp.com>
Message-ID: <87a7qe1cds.fsf@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pengbo Mu <pengbo.mu@nxp.com> writes:

> Property "snps,incr-burst-type-adjustment = <x>, <y>..." for USB3.0
> DWC3.When only one value means INCRx mode with fix burst type.
> When more than one value, means undefined length burst mode, USB
> controller can use the length less than or equal to the largest
> enabled burst length.
>
> While enabling undefined length INCR burst type and INCR16 burst type,
> get better write performance on NXP Layerscape platforms: around 3%
> improvement (from 364MB/s to 375MB/s).
>
> Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
> Signed-off-by: Pengbo Mu <pengbo.mu@nxp.com>

will this go through arm64 tree or do you need me to pick it up?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180726/0c6f0cba/attachment.sig>
