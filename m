From: will.deacon@arm.com (Will Deacon)
Date: Mon, 15 Feb 2016 15:51:09 +0000
Subject: [PATCH] arm/arm64/crypto: assure that ECB modes don't require an
 IV
In-Reply-To: <CAKv+Gu8_Z5=0dTeBsVgx_BT0c+_O5PNUCyKFjuDf9x470bxHOA@mail.gmail.com>
References: <1455292072-5236-1-git-send-email-jeremy.linton@arm.com>
 <CAKv+Gu8_Z5=0dTeBsVgx_BT0c+_O5PNUCyKFjuDf9x470bxHOA@mail.gmail.com>
Message-ID: <20160215155108.GG6298@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 12, 2016 at 06:00:01PM +0100, Ard Biesheuvel wrote:
> On 12 February 2016 at 16:47, Jeremy Linton <jeremy.linton@arm.com> wrote:
> > ECB modes don't use an initialization vector. The kernel
> > /proc/crypto interface doesn't reflect this properly.
> >
> > Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> 
> Thanks for spotting that!
> 
> Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Thanks, I'll queue this for -rc5.

Will
