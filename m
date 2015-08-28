From: peter.griffin@linaro.org (Peter Griffin)
Date: Fri, 28 Aug 2015 18:09:24 +0100
Subject: [PATCH v2 3/5] [media] c8sectpfe: Remove select on undefined
 LIBELF_32
In-Reply-To: <20150828065830.GE4796@x1>
References: <1440678575-21646-1-git-send-email-peter.griffin@linaro.org>
 <1440678575-21646-4-git-send-email-peter.griffin@linaro.org>
 <20150828065830.GE4796@x1>
Message-ID: <20150828170924.GB18136@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

On Fri, 28 Aug 2015, Lee Jones wrote:

> On Thu, 27 Aug 2015, Peter Griffin wrote:
> 
> > LIBELF_32 is not defined in Kconfig, and is left over legacy
> > which is not required in the upstream driver, so remove it.
> > 
> > Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> > Suggested-by: Valentin Rothberg <valentinrothberg@gmail.com>
> 
> These are the wrong way round, they should be in chronological order.

Ok will fix in v3.

regards,

Peter.
