From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 10 Dec 2012 13:20:02 +0000
Subject: [PATCH 1/2] ARM: net: bpf_jit_32: fix kzalloc gfp/size mismatch.
In-Reply-To: <50C5E143.4070306@freebox.fr>
References: <1354804718-1662-1-git-send-email-nschichan@freebox.fr>
 <50C2760A.9070406@gmail.com> <50C5E143.4070306@freebox.fr>
Message-ID: <20121210132002.GJ14363@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 10, 2012 at 02:18:59PM +0100, Nicolas Schichan wrote:
> On 12/08/2012 12:04 AM, Mircea Gherzan wrote:
>> Am 06.12.2012 15:38, schrieb Nicolas Schichan:
> [...]
>> Acked-by: Mircea Gherzan<mgherzan@gmail.com>
>
> Hi,
>
> Thanks for acking those two patches.
>
> Shall I send them to the patch system now ?

Yes please.
