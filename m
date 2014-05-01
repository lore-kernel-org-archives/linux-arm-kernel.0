From: Brian.Austin@cirrus.com (Austin, Brian)
Date: Thu, 1 May 2014 12:26:18 +0000
Subject: [alsa-devel] [PATCH 01/15] ASoC: CS42L51 and WM8962 codecs
 depend on INPUT
In-Reply-To: <20140501032756.GM3245@sirena.org.uk>
References: <1398770316-19715-1-git-send-email-kaixu.xia@linaro.org>
 <1398770316-19715-2-git-send-email-kaixu.xia@linaro.org>
 <alpine.DEB.2.02.1404292124270.31465@heelrod>
 <20140501013103.GK3245@sirena.org.uk>
 <13D36045-EE68-418B-983B-2704C52391E3@cirrus.com>
 <08914164-8CE6-4170-BC21-9E2840FFA05E@cirrus.com>,
 <20140501032756.GM3245@sirena.org.uk>
Message-ID: <C1FD6191-8850-4BB1-ABA1-BE6D02F9CD84@cirrus.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> On Apr 30, 2014, at 22:28, "Mark Brown" <broonie@kernel.org> wrote:
> 
>> On Thu, May 01, 2014 at 02:16:27AM +0000, Austin, Brian wrote:
>> 
>> Apparently not.
>> I would like to come up with a better solution than making INPUT a requirement. I just need some time.
>> In the meantime I suppose it?s OK to apply it?
> 
> Yeah.  Realistically it's probably not going to ever be a practical
> problem - the number of systems with audio but no input is likely to be
> very close to zero.

Yeah, I'm just gonna go ahead and remove the #if's from the drivers then since it's required 
