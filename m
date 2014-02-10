From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Mon, 10 Feb 2014 11:42:15 +0100
Subject: [PATCH 09/17] spi: pl022: Simplify clock handling
In-Reply-To: <20140204191947.GV22609@sirena.org.uk>
References: <1391529538-21685-1-git-send-email-ulf.hansson@linaro.org>
 <1391529538-21685-10-git-send-email-ulf.hansson@linaro.org>
 <20140204191947.GV22609@sirena.org.uk>
Message-ID: <CAPDyKFqV+5T5jFgjWZ9zkbC3Oijq=7fVBhM9BDLQtDa_c8Yftg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 February 2014 20:19, Mark Brown <broonie@kernel.org> wrote:
> On Tue, Feb 04, 2014 at 04:58:50PM +0100, Ulf Hansson wrote:
>> Make use of clk_prepare_enable and clk_disable_unprepare to simplify
>> code. No functional change.
>
> I went ahead and applied this since it looks good and seems like an
> unrelated cleanup to the runtime PM stuff which seems to be where the
> interdependencies are - thanks!  It's on a separate branch with the
> already applied change so if it does need to be cross merged we can do
> that easily or even drop the branch.

Thanks Mark, it seems like a good approach.

Kind regards
Ulf Hansson
