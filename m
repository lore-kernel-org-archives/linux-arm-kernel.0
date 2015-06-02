From: broonie@kernel.org (Mark Brown)
Date: Tue, 2 Jun 2015 20:14:38 +0100
Subject: [PATCH V6 1/3] OPP: Add new bindings to address shortcomings of
 existing bindings
In-Reply-To: <20150602183120.GB24349@codeaurora.org>
References: <cover.1432797343.git.viresh.kumar@linaro.org>
 <96d49e7e6747c1a65c5f285d70600795126641cc.1432797343.git.viresh.kumar@linaro.org>
 <20150602183120.GB24349@codeaurora.org>
Message-ID: <20150602191438.GF14071@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 02, 2015 at 11:31:20AM -0700, Stephen Boyd wrote:
> On 05/28, Viresh Kumar wrote:

> > +			opp-supply = <&cpu_supply0>;

> opp-supply isn't mentioned anywhere. Is that intentional? Is it
> supposed to be cpu-supply still? It isn't clear to me from the

I'm also a bit worried about the naming here - regulator supplies should
always reflect the name of the supply in the hardware and it seems
unlikely that this is one.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150602/a90a37b2/attachment.sig>
