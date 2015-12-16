From: panand@redhat.com (Pratyush Anand)
Date: Wed, 16 Dec 2015 13:06:22 +0530
Subject: [PATCH v12 11/16] arm64: kdump: reserve memory for crash dump
 kernel
In-Reply-To: <5670F45E.7060100@linaro.org>
References: <cover.1448403503.git.geoff@infradead.org>
 <bc962621bd537244b54fc35627a456ab40bc6d26.1448403503.git.geoff@infradead.org>
 <20151215172953.GD353@arm.com> <5670F45E.7060100@linaro.org>
Message-ID: <20151216073622.GJ4674@dhcppc13.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/12/2015:02:19:26 PM, AKASHI Takahiro wrote:
> On 12/16/2015 02:29 AM, Will Deacon wrote:
> >#else
> >
> >static void __init reserve_crashkernel(void) {};
> 
> OK.

Then may be you do not need to protect calling of reserve_crashkernel() with
CONFIG_KEXEC_CORE as well.

~Pratyush
