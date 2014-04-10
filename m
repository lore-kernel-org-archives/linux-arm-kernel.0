From: robherring2@gmail.com (Rob Herring)
Date: Thu, 10 Apr 2014 18:01:31 -0500
Subject: [PATCH] ARM: topology: Make it clear that all CPUs need to be
 described
In-Reply-To: <20140331093046.GA2245@e102568-lin.cambridge.arm.com>
References: <1396016467-23257-1-git-send-email-broonie@kernel.org>
 <20140331093046.GA2245@e102568-lin.cambridge.arm.com>
Message-ID: <CAL_JsqLj56d6Mb5Vjd4UnBvQ6myAc4j3moY+3EM9zgHxrNgHbw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 31, 2014 at 4:30 AM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> On Fri, Mar 28, 2014 at 02:21:07PM +0000, Mark Brown wrote:
>> From: Mark Brown <broonie@linaro.org>
>>
>> The ARMv8 code will reject topologies that omit some CPUs (and it's not
>> clear that it's ever sensible to do so). Update the binding document to
>> make this clear.
>>
>> Since we're reformatting the text also fix incorrect grammar in the
>> final "Any other configuration..." section by removing "consider".
>
> I think the commit log should be reworded, we update the bindings
> because they are incomplete, not because ARMv8 code decided to reject
> topologies that omit CPUs.
>
> Patch is ok with me, thanks:
>
> Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

Applied for 3.15.

Rob
