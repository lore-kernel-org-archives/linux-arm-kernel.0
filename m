From: olof@lixom.net (Olof Johansson)
Date: Fri, 8 Nov 2013 16:39:19 -0800
Subject: [PATCH 2/5] arm64: Add APM X-Gene SATA DTS binding
In-Reply-To: <1383949838-25106-3-git-send-email-lho@apm.com>
References: <1383949838-25106-1-git-send-email-lho@apm.com>
 <1383949838-25106-2-git-send-email-lho@apm.com>
 <1383949838-25106-3-git-send-email-lho@apm.com>
Message-ID: <20131109003919.GB22982@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 08, 2013 at 03:30:35PM -0700, Loc Ho wrote:
> Signed-off-by: Loc Ho <lho@apm.com>
> Signed-off-by: Tuan Phan <tphan@apm.com>
> Signed-off-by: Suman Tripathi <stripathi@apm.com>
> ---
>  arch/arm64/boot/dts/apm-storm.dtsi |   73 ++++++++++++++++++++++++++++++++++++
>  1 files changed, 73 insertions(+), 0 deletions(-)

Technically this patch doesn't add a binding (the binding is just the
documentation part), it updates the device tree with the SATA devices.

Also, again: Patch description! Not optional.


-Olof
