From: panand@redhat.com (Pratyush Anand)
Date: Thu, 28 Jul 2016 09:40:53 +0530
Subject: [PATCH v2 3/4] arm64: Add arm64 kexec support
In-Reply-To: <fbb0f30aa1493b40c53264c9b5ae62b46606bd61.1469559530.git.geoff@infradead.org>
References: <cover.1469559530.git.geoff@infradead.org>
 <fbb0f30aa1493b40c53264c9b5ae62b46606bd61.1469559530.git.geoff@infradead.org>
Message-ID: <20160728041053.GB27150@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/07/2016:08:18:57 PM, Geoff Levand wrote:
> Add kexec reboot support for ARM64 platforms.
> 
> Signed-off-by: Geoff Levand <geoff@infradead.org>
> ---

[...]

> +
> +#define OPT_APPEND		((OPT_MAX)+0)
> +#define OPT_DTB			((OPT_MAX)+1)
> +#define OPT_INITRD		((OPT_MAX)+2)
> +#define OPT_REUSE_CMDLINE	((OPT_MAX)+4)

Option count 3 is missing. 

> +#define OPT_ARCH_MAX		((OPT_MAX)+5)

~Pratyush
