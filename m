From: broonie@kernel.org (Mark Brown)
Date: Mon, 4 May 2015 13:12:09 +0100
Subject: [PATCH V4 1/3] OPP: Redefine bindings to overcome shortcomings
In-Reply-To: <d225e73f183e01fa0b71e4b9248b6a19a3f7d697.1430394884.git.viresh.kumar@linaro.org>
References: <cover.1430394884.git.viresh.kumar@linaro.org>
 <d225e73f183e01fa0b71e4b9248b6a19a3f7d697.1430394884.git.viresh.kumar@linaro.org>
Message-ID: <20150504121209.GM15510@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 30, 2015 at 05:37:59PM +0530, Viresh Kumar wrote:

> +- opp-microamp: current in micro Amperes. It can contain entries for multiple
> +  regulators.
> +
> +  A single regulator's current is specified with an array of size one or three.
> +  Single entry is for target current and three entries are for <target min max>
> +  currents.

What is this for - are you trying to define OPPs for current regulators?
If you are that's worrying, I can't think of a sensible use case.  If
that's not what's happening then the binding needs to be more specific
about what this is supposed to mean.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150504/ed7ced6f/attachment.sig>
