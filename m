From: broonie@kernel.org (Mark Brown)
Date: Sat, 20 Feb 2016 01:17:49 +0900
Subject: [PATCH] regulator: qcom-saw: avoid uninitialized variable warning
In-Reply-To: <1455183497-299798-1-git-send-email-arnd@arndb.de>
References: <1455183497-299798-1-git-send-email-arnd@arndb.de>
Message-ID: <20160219161749.GX18327@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 11, 2016 at 10:38:08AM +0100, Arnd Bergmann wrote:
> gcc cannot know that a for_each_possible_cpu() loop always executes
> at least once, so it warns about the use of the "found" variable
> in qcom_saw_regulator_probe:

I'm going to drop this driver so this won't be needed.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160220/fb3c8d40/attachment.sig>
