From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 23 Nov 2010 22:08:25 +0800
Subject: [PATCH 1/2] pxa: add usb clock for pxa168/pxa910
In-Reply-To: <AAD1C6EB06EE3649B35B7E026785068D15054F6FCA@SC-VEXCH2.marvell.com>
References: <1290418347-6861-1-git-send-email-chao.xie@marvell.com>
	<AANLkTimq2--4rXRO9XbL3DnsTQhJmh-A4b3RarMy1xa=@mail.gmail.com>
	<AAD1C6EB06EE3649B35B7E026785068D15054F6FCA@SC-VEXCH2.marvell.com>
Message-ID: <AANLkTinkNOvWd1En4qoaTpebgce40-7A9bPad3Y+Yk82@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 23, 2010 at 11:12 AM, Chao Xie <cxie4@marvell.com> wrote:
> Hi
> Modified as you suggested. Patch is attached.
> ...
> ? ? ? ?INIT_CLKREG(&clk_nand, "pxa3xx-nand", NULL),
> + ? ? ? INIT_CLKREG(&clk_u2o, "pxa-u2o", "U2OCLK"),
> ...

Applied to 'devel'.
