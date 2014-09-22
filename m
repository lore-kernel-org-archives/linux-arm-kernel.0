From: pavel@ucw.cz (Pavel Machek)
Date: Mon, 22 Sep 2014 21:48:41 +0200
Subject: [PATCH v4 18/18] Documentation: ACPI for ARM64
In-Reply-To: <1410530416-30200-19-git-send-email-hanjun.guo@linaro.org>
References: <1410530416-30200-1-git-send-email-hanjun.guo@linaro.org>
 <1410530416-30200-19-git-send-email-hanjun.guo@linaro.org>
Message-ID: <20140922194841.GA9868@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri 2014-09-12 22:00:16, Hanjun Guo wrote:
> From: Graeme Gregory <graeme.gregory@linaro.org>
> 
> Add documentation for the guidelines of how to use ACPI
> on ARM64.

> +No code shall be accepted into the kernel unless it complies with the released
> +standards from UEFI ASWG. If there are features missing from ACPI to make it
> +function on a platform, ECRs should be submitted to ASWG and go through the
> +approval process.

Surely this should be narrowed down somehow? Or is reading all the
released standards from ASWG mandatory before patching the kernel now?

Spelling out wtf ECR is would be nice, too.

And if you expect all kernel contributors to comply with your
favourite standards, you should put an URL where the standards can be
downloaded here.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
