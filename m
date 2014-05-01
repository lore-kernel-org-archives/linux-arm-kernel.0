From: Brian.Austin@cirrus.com (Austin, Brian)
Date: Thu, 1 May 2014 02:16:27 +0000
Subject: [alsa-devel] [PATCH 01/15] ASoC: CS42L51 and WM8962 codecs
 depend on INPUT
In-Reply-To: <13D36045-EE68-418B-983B-2704C52391E3@cirrus.com>
References: <1398770316-19715-1-git-send-email-kaixu.xia@linaro.org>
 <1398770316-19715-2-git-send-email-kaixu.xia@linaro.org>
 <alpine.DEB.2.02.1404292124270.31465@heelrod>,
 <20140501013103.GK3245@sirena.org.uk>
 <13D36045-EE68-418B-983B-2704C52391E3@cirrus.com>
Message-ID: <08914164-8CE6-4170-BC21-9E2840FFA05E@cirrus.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Apr 30, 2014, at 8:54 PM, Austin, Brian <Brian.Austin@cirrus.com> wrote:

> 
> 
>> On Apr 30, 2014, at 20:31, "Mark Brown" <broonie@kernel.org> wrote:
>> 
>>> On Tue, Apr 29, 2014 at 09:31:30PM -0500, Brian Austin wrote:
>>> 
>>> I assume you mean the CS42L52 instead of the L51. INPUT is used for a BEEP
>>> Generator but when I disable CONFIG_INPUT I do not get an error. Is there
>>> any information available on what the error is?
>> 
>> I suspect it's ASoC built in and INPUT build as a module.
> Ok, I'll try that next.
> Doesn't IS_ENABLED cover that?
Apparently not.
I would like to come up with a better solution than making INPUT a requirement. I just need some time.
In the meantime I suppose it?s OK to apply it? 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 496 bytes
Desc: Message signed with OpenPGP using GPGMail
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140501/caceff69/attachment.sig>
