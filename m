From: ccross@android.com (Colin Cross)
Date: Sat, 2 Oct 2010 13:21:28 -0700
Subject: [PATCH 2/2] gic: Export irq chip functions
In-Reply-To: <AANLkTinSgSWakhXaHN9svA7ruRF6w4tbOugdd5g+xF2i@mail.gmail.com>
References: <1285901335-26354-1-git-send-email-ccross@android.com>
	<1285901335-26354-2-git-send-email-ccross@android.com>
	<AANLkTinSgSWakhXaHN9svA7ruRF6w4tbOugdd5g+xF2i@mail.gmail.com>
Message-ID: <AANLkTikTLgNe+JSeBAumsAsDvDxUzepf62CgFqWaq8LY@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 2, 2010 at 11:03 AM, Linus Walleij
<linus.ml.walleij@gmail.com> wrote:
> 2010/10/1 Colin Cross <ccross@android.com>:
>
>> Some systems combine the GIC with an external interrupt controller.
>
> Which ones?
>
> In-tree systems (in which case it would be natural to include these changes
> the patch series) or stuff you plan to submit later?

Tegra, these patches are a precursor to the Tegra suspend support
series.  If there's nothing obviously wrong with these, I'll repost
them along with the rest of the series.
