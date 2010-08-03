From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 3 Aug 2010 19:09:51 +0800
Subject: [PATCH 0/3] Enable Fast Ethernet on Aspenite.
In-Reply-To: <1280849830-5350-1-git-send-email-ssanap@marvell.com>
References: <1280849830-5350-1-git-send-email-ssanap@marvell.com>
Message-ID: <AANLkTinYOSOzcA96TXW3ow8PPJ0XiH6XhsXdiD10P+ah@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 3, 2010 at 11:37 PM, Sachin Sanap <ssanap@marvell.com> wrote:
> Following is the series of 3 patches that will help get the Fast Ethernet
> driver functional on PXA168 based Aspenite boards.Same driver can be used
> for other PXA168 based boards as well but that will come later.First patch
> adds MAX7312, second patch adds the necessary MFU pins, and third adds
> ethernet specific initializations.
>

Cc'ed Zhangfei.

> These patches were generated against 2.6.35-rc5
> commit cd5b8f8755a89a57fc8c408d284b8b613f090345
>
>
> Sachin Sanap (3):
> ?[ARM] pxa: Hookup MAX7312 thats connected to I2C.
> ?[ARM] pxa: MFU pin configuration to support Fast ethernet.
> ?[ARM] pxa: Add support for Fast Ethernet driver.
>
> ?arch/arm/mach-mmp/aspenite.c ? ? ? ? ? ? ? ?| ? 83 ++++++++++++++++++++++++++-
> ?arch/arm/mach-mmp/include/mach/devices.h ? ?| ? ?1 +
> ?arch/arm/mach-mmp/include/mach/mfp-pxa168.h | ? 19 ++++++
> ?arch/arm/mach-mmp/include/mach/pxa168.h ? ? | ? ?9 +++
> ?arch/arm/mach-mmp/include/mach/regs-apmu.h ?| ? ?1 +
> ?arch/arm/mach-mmp/pxa168.c ? ? ? ? ? ? ? ? ?| ? ?3 +
> ?6 files changed, 114 insertions(+), 2 deletions(-)
>
>
