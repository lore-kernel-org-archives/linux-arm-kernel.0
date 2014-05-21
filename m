From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed, 21 May 2014 15:00:43 +0200
Subject: [PATCH] i2c: exynos5: Initialise Samsung High Speed I2C
 controller early
In-Reply-To: <CAHfPSqCOnW4YGPfMfpBMbLSaiSxRN=CHJK6kYdkXMujKvNwAPA@mail.gmail.com>
References: <1398350916-885-1-git-send-email-ch.naveen@samsung.com>
 <20140424162558.GB12304@sirena.org.uk>
 <CAHfPSqB5+mLiC07jbEpeUgW63pZVk700SkYGxToO7GRAsFm_nQ@mail.gmail.com>
 <20140509135153.GM12304@sirena.org.uk>
 <CAHfPSqDSTyQXPT-NCZ2hE01qpdmaR54tbWCUYC_zSDGFp58+7g@mail.gmail.com>
 <20140509145425.GP12304@sirena.org.uk>
 <20140521102515.GJ2708@katana>
 <CAHfPSqCOnW4YGPfMfpBMbLSaiSxRN=CHJK6kYdkXMujKvNwAPA@mail.gmail.com>
Message-ID: <20140521130043.GA2628@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Kindly, suggest a workable approach for all the subsystems.

Keep this patch out-of-tree? I know that probe ordering causes problems,
and that it needs major efforts. Yet, I understood that adding more and
more subsys_initcall to mainline is not going to help the process unless
essential. Using subsys_initcall has issues, too.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140521/59d62bb1/attachment.sig>
