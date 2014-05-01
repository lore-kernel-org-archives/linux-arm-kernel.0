From: broonie@kernel.org (Mark Brown)
Date: Wed, 30 Apr 2014 20:27:56 -0700
Subject: [alsa-devel] [PATCH 01/15] ASoC: CS42L51 and WM8962 codecs
 depend on INPUT
In-Reply-To: <08914164-8CE6-4170-BC21-9E2840FFA05E@cirrus.com>
References: <1398770316-19715-1-git-send-email-kaixu.xia@linaro.org>
 <1398770316-19715-2-git-send-email-kaixu.xia@linaro.org>
 <alpine.DEB.2.02.1404292124270.31465@heelrod>
 <20140501013103.GK3245@sirena.org.uk>
 <13D36045-EE68-418B-983B-2704C52391E3@cirrus.com>
 <08914164-8CE6-4170-BC21-9E2840FFA05E@cirrus.com>
Message-ID: <20140501032756.GM3245@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 01, 2014 at 02:16:27AM +0000, Austin, Brian wrote:

> Apparently not.
> I would like to come up with a better solution than making INPUT a requirement. I just need some time.
> In the meantime I suppose it?s OK to apply it? 

Yeah.  Realistically it's probably not going to ever be a practical
problem - the number of systems with audio but no input is likely to be
very close to zero.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140430/75e65354/attachment.sig>
