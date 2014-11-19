From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Wed, 19 Nov 2014 10:51:49 +0100
Subject: [PATCH V8 00/14] drm/exynos: few patches to enhance bridge chip
 support
In-Reply-To: <CAEC9eQPz_7QeL7EDorb-OxiTjcb1tVUDbEbzbER4Yu2wSNNaxQ@mail.gmail.com>
References: <1416045309-13359-1-git-send-email-ajaykumar.rs@samsung.com>	<CAEC9eQOrKw2Z1q-ztFfadXmsL3CTcAkkv9kcS2QnDOAVSh2AuQ@mail.gmail.com>	<546C646C.4060303@collabora.co.uk>
 <CAEC9eQPz_7QeL7EDorb-OxiTjcb1tVUDbEbzbER4Yu2wSNNaxQ@mail.gmail.com>
Message-ID: <546C6835.7040802@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Ajay,

On 11/19/2014 10:38 AM, Ajay kumar wrote:
> Hi Javier,
> 
> In the cover letter, I have mentioned that it is tested on Linus tree:
> 
> "This series is based on master branch of Linus tree at:
> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git"
> 
> Kindly test the patches with that.
> 

That's what I did... Linus' master branch is a moving target and if you
look at his current HEAD, it is commit fc14f9c1 ("Linux 3.18-rc5") but
as I said before, at least two patches that are needed didn't land in
Linus' tree yet. These are:

0ef76ae ("ARM: exynos_defconfig: Enable options for display panel support")
e35e305 ("drm/panel: simple: Add AUO B116XW03 panel support")

IOW, linux.git master branch + this series is not enough to have display
working AFAICT so I was wondering if I'm missing something else.

Do you have a public tree somewhere with the branch you are using to test?

Best regards,
Javier
