From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 02 Apr 2012 12:08:23 -0700
Subject: [PATCH v3 0/6] mmc: sdhci-s3c: Rework platform data and add device
 tree support
In-Reply-To: <87zkawmf08.fsf@laptop.org>
References: <1328032576-9269-1-git-send-email-thomas.abraham@linaro.org>
 <003401cce730$baf979a0$30ec6ce0$%kim@samsung.com>
 <m2aa4pkq5g.fsf@bob.laptop.org> <4F3CFEED.6060206@samsung.com>
 <m239abgc32.fsf@bob.laptop.org>
 <00b901ccf08d$2fc18b50$8f44a1f0$%kim@samsung.com>
 <m2vcn0496y.fsf@bob.laptop.org> <87k426vy9r.fsf@laptop.org>
 <20120328095450.GA23005@sirena.org.uk> <4F73D3D7.1010202@samsung.com>
 <87zkawmf08.fsf@laptop.org>
Message-ID: <4F79F927.5060707@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Chris Ball wrote:
> Hi Kukjin,
>
Hi,

Sorry for late response.

[...]

>
> I can't send the tree as it is to Linus now, because Arnd has asked us
> to hold off on these device tree bindings and work with the unified
> bindings he's proposing instead.  (Rebasing to drop that patch will
> introduce new conflicts.)
>
OK, I see.

> I'm going to send Mark Brown's two patches to Linus now, even though it
> will cause a conflict in -next.  The rest (other than the device tree
> bindings) are mergable after -rc1, because they're fixes, so we'll
> eventually get everything except DT in to 3.4.  I think you should
> just drop this patchset from your tree in linux-next entirely now.
>
Yep, I dropped it in my -next.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
