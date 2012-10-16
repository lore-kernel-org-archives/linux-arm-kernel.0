From: olof@lixom.net (Olof Johansson)
Date: Tue, 16 Oct 2012 11:17:58 -0700
Subject: [RFC PATCHv2] ARM: vt8500: Convert arch-vt8500 to multiplatform
In-Reply-To: <1349942353-14972-1-git-send-email-linux@prisktech.co.nz>
References: <1349942353-14972-1-git-send-email-linux@prisktech.co.nz>
Message-ID: <20121016181758.GA1801@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 11, 2012 at 08:59:13PM +1300, Tony Prisk wrote:
> This patch completes the conversion to ARCH_MULTI_V5 for arch-vt8500.
> Removed /mach/include/ and remaining unneeded files.
> 
> Signed-off-by: Tony Prisk <linux@prisktech.co.nz>

Acked-by: Olof Johansson <olof@lixom.net>

I think it's time to add a defconfig for vt8500 so we get build coverage. Can
you please do so for 3.8, maybe as a part of the branch this patch goes in?


Thanks!


-Olof
