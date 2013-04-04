From: cdall@cs.columbia.edu (Christoffer Dall)
Date: Thu, 4 Apr 2013 08:36:04 -0700
Subject: Problem building 3.9rc5 - with CONFIG_AUTO_ZRELADDR
In-Reply-To: <2DDB038789B01B4B80B0D3F1FF7CBDC2064D2F80@lhreml509-mbb.china.huawei.com>
References: <2DDB038789B01B4B80B0D3F1FF7CBDC2064D2F42@lhreml509-mbb.china.huawei.com>
 <2DDB038789B01B4B80B0D3F1FF7CBDC2064D2F5F@lhreml509-mbb.china.huawei.com>
 <2DDB038789B01B4B80B0D3F1FF7CBDC2064D2F80@lhreml509-mbb.china.huawei.com>
Message-ID: <CAEDV+g+Amoc33GkvXS+e0+g7TEYtDN9RyTz8uOo4kk7Qr+iM8A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 4, 2013 at 7:48 AM, Mario Smarduch
<Mario.Smarduch@huawei.com> wrote:
> Hello,
>
> I'm building 3.9rc5 Host the build fails in arch/arm/boot/Makefile.
> check_for_multiple_loadaddr (issued from uImage:) checks if $(UIMAGE_LOADADDR) -ne 1.
> With CONFIG_AUTO_ZRELADDR set kernel decompressed load address is determine dynamically.
> The build doesn't seem to take that into consideration it expects ZRELADDR set.
> 3.8rc4 had 'if $(UIMAGE_LOADADDR) -gt 1', what I would expect.
>
> Does someone know what's hidden behind this subtle change? Before looking for workarounds.
>
Eh, this is a little hard to guess at. Can you send your kernel config?

-Christoffer
