From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 22 Dec 2009 22:02:09 +0800
Subject: arm/plat-pxa/pwm.c: use resource_size()
In-Reply-To: <BD79186B4FD85F4B8E60E381CAEE190901EE5BD7@mi8nycmail19.Mi8.com>
References: <AcpsYdG/HtrnoycfRvWUq1a0CUtmoA==>
	<BD79186B4FD85F4B8E60E381CAEE190901EE5BD7@mi8nycmail19.Mi8.com>
Message-ID: <f17812d70912220602i3f709c5rc07f4967d71f4f80@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 24, 2009 at 1:24 AM, H Hartley Sweeten
<hartleys@visionengravers.com> wrote:
> Use resource_size for {request/release}_mem_region and ioremap.
>
> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>

Applied. Sorry - over looked this before last merge window.
