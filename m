From: khilman@kernel.org (Kevin Hilman)
Date: Tue, 30 Sep 2014 10:35:45 -0700
Subject: [PATCH v7 4/7] qcom: pm: Add cpu low power mode functions
In-Reply-To: <20140930160310.GC528@ilina-mac.local> (Lina Iyer's message of
 "Tue, 30 Sep 2014 10:03:10 -0600")
References: <1411779495-39724-1-git-send-email-lina.iyer@linaro.org>
 <1411779495-39724-5-git-send-email-lina.iyer@linaro.org>
 <5429ED1D.5060809@codeaurora.org>
 <20140930160310.GC528@ilina-mac.local>
Message-ID: <7h4mvp105q.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lina Iyer <lina.iyer@linaro.org> writes:

> On Mon, Sep 29 2014 at 17:37 -0600, Stephen Boyd wrote:
>>On 09/26/14 17:58, Lina Iyer wrote:
>>> Based on work by many authors, available at codeaurora.org
>>>
>>
>>> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
>>> [lina: simplify the driver for an initial submission, add commit text
>>> description of idle states]
>>
>>Maintainer tags don't really make sense unless there is another author.
>>
> Hmm.. Since this patch is a derivative work, I wanted to clarify, what
> changed seems important. The work was done by many authors. Adding
> signed-off from everybody who could have contributed to the patch
> downstream is confusing.
> I would be okay removing it.

Yes, you should remove it, but move the "Based on work by many authors"
part to just before your signoff.  Also, it's considered good manners to
name any significant contributors if there are a few standouts.  Also,
the "available at codeaurora.org" is wanting a link, ideally to a
specific commit, or a branch so original code can easily be found.

Kevin
 
