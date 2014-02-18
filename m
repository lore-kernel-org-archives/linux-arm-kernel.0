From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Tue, 18 Feb 2014 23:02:09 +0100
Subject: [PATCH V3 11/17] i2c: nomadik: Convert to devm functions
In-Reply-To: <CAPDyKFrBPy+QxgU-PpcGsvy8n=GLEWZHA+0FLfhnV780tt8YWQ@mail.gmail.com>
References: <1392650418-14820-1-git-send-email-ulf.hansson@linaro.org>
 <20140218110109.GA18768@katana>
 <CAPDyKFpRaAAer00dqcXR-qOT9S8-SDTnaMUHRwWCZ93w-wnTDA@mail.gmail.com>
 <20140218184327.GF18768@katana>
 <CAPDyKFrBPy+QxgU-PpcGsvy8n=GLEWZHA+0FLfhnV780tt8YWQ@mail.gmail.com>
Message-ID: <CAPDyKFqtXz8wiF7X4eZ_rPUOwgVQ6poXWhNnNxjKMmdF5jztTA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18 February 2014 21:50, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 18 February 2014 19:43, Wolfram Sang <wsa@the-dreams.de> wrote:
>>
>>> I added the IS_ERR, check as you suggested. That caused a rebase of
>>> the other patches as well.
>>>
>>> Sorry if it was unclear.
>>
>> No problem. I am about to apply all patches except 17 as you suggested.
>> It fails here, however, although I applied Linus' patch first. What
>> exactly is your base? Any chance to publish your branch?
>>
>
> I have several branches. :-)
>
> My patches applies on top 3.14-rc1 + Linus' patch.
>
> It also applies on
> "git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-nomadik.git"
> on the i2c-nomadik, which already holds Linus's patch. This is what I
> thought was important due what's stated in the MAINATAINERS file.
>
> Now, I guess I should use your tree instead,
> "git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git". Any
> particular branch I should use?  Maybe it's also better if I just
> resend the patches in a new patchset, once I rebased them towards your
> tree?

Sorry, I have taken Linus v1 patch as base, it should have been v2 of
course. Sorry for wasting your time.

I will rebase and send v4 patches asap.

Kind regards
Uffe

>
> Kind regards
> Uffe
