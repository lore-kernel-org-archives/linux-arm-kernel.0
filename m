From: gregkh@linuxfoundation.org (Greg KH)
Date: Mon, 18 Sep 2017 12:55:20 +0200
Subject: [RFC RESEND 0/3] Add support for Hisilicon Hi3521A SoC
In-Reply-To: <20170917082327.10058-1-hanetzer@startmail.com>
References: <20170917082327.10058-1-hanetzer@startmail.com>
Message-ID: <20170918105520.GA2837@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 17, 2017 at 03:23:24AM -0500, Marty E. Plummer wrote:
> Greetings,
> 
> I'd like the community's feedback on the following patchset. I've attempted to
> split my changes up in what I believe to be a sensible setup.
> 
> The device I'm working against is the 'SamsungSV SDR-B74301' HD CCTV surveillance
> system, which uses a Hisilicon Hi3521A arm SoC as its basis.
> 
> Resending due to a typo, s/primcell/primecell/
> 
> Marty E. Plummer (3):
>   clk: hisilicon: add CRG driver Hi3521A SoC
>   arm: hisi: enable Hi3521A SoC
>   arm: dts: add Hi3521A dts

Seems reasonable to me, but I'll let the clk maintainers/developers give
you a better review...

thanks,

greg k-h
