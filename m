From: john.stultz@linaro.org (John Stultz)
Date: Mon, 28 Mar 2011 11:07:18 -0700
Subject: [PATCH V13 2/4] ptp: Added a clock that uses the eTSEC found
	on the MPC85xx.
In-Reply-To: <120e586f678230c5f7d6dcfe70aa4483c2d50bf5.1301206090.git.richard.cochran@omicron.at>
References: <cover.1301206090.git.richard.cochran@omicron.at>
	<120e586f678230c5f7d6dcfe70aa4483c2d50bf5.1301206090.git.richard.cochran@omicron.at>
Message-ID: <1301335638.21829.1.camel@work-vm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2011-03-27 at 08:38 +0200, Richard Cochran wrote:
> The eTSEC includes a PTP clock with quite a few features. This patch adds
> support for the basic clock adjustment functions, plus two external time
> stamps, one alarm, and the PPS callback.
> 
> Signed-off-by: Richard Cochran <richard.cochran@omicron.at>

Acked-by: John Stultz <john.stultz@linaro.org>
