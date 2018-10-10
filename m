From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 10 Oct 2018 19:59:05 +0530
Subject: [PATCH 6/9] PM / OPP: dt-bindings: Add opp-interconnect-bw
In-Reply-To: <20181010142723.GA9977@jcrouse-lnx.qualcomm.com>
References: <20180827151112.25211-1-jcrouse@codeaurora.org>
 <20180827151112.25211-7-jcrouse@codeaurora.org>
 <0998a374-6cb0-9218-d2e3-92f8ee9861ed@linaro.org>
 <20181010095951.hgeiy7yxsqi6behd@vireshk-i7>
 <20181010142723.GA9977@jcrouse-lnx.qualcomm.com>
Message-ID: <20181010142905.n44dkuq725jwiqph@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10-10-18, 08:27, Jordan Crouse wrote:
> I'm not convinced that required-opps would work. I'm worried that the
> format is too vague if we need to use it for multiple paths and possibly
> other uses too, consider this:
> 
> required-opp = <&mdp_path0_opp3, &mdp_path1_opp5, &mdp_rpmh_opp1>;
> 
> This has ordering problems and IMO pollutes the DT namespace for no
> great technical advantage. I appreciate the hesitation for opening up
> the flood gates for new OPP bindings but we are entering a new era
> of hyper power aware devices and some concessions will need to be made.

Sure.

-- 
viresh
