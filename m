From: Rob Herring <robh@kernel.org>
To: Jeremy McNicoll <jmcnicol@redhat.com>
Cc: andy.gross at linaro.org, sboyd at codeaurora.org, arnd at arndb.de,
	bjorn.andersson at linaro.org, git at kchr.de, jeremymc at redhat.com,
	linux-arm-msm at vger.kernel.org, linux-soc at vger.kernel.org,
	devicetree at vger.kernel.org
Subject: Re: [RFC V2 PATCH 04/12] dt-bindings: qcom: Add msm8992 bindings
Message-ID: <20161008224105.GA18534@rob-hp-laptop>
References: <1475375919-618-1-git-send-email-jmcnicol@redhat.com>
 <1475375919-618-5-git-send-email-jmcnicol@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1475375919-618-5-git-send-email-jmcnicol@redhat.com>
Date: Sat, 8 Oct 2016 17:41:09 -0500
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 01, 2016 at 07:38:31PM -0700, Jeremy McNicoll wrote:
> Signed-off-by: Jeremy McNicoll <jeremymc@redhat.com>
> ---
>  Documentation/devicetree/bindings/arm/qcom.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/qcom.txt b/Documentation/devicetree/bindings/arm/qcom.txt
> index 3e24518..fc5d5ee 100644
> --- a/Documentation/devicetree/bindings/arm/qcom.txt
> +++ b/Documentation/devicetree/bindings/arm/qcom.txt
> @@ -22,6 +22,7 @@ The 'SoC' element must be one of the following strings:
>  	msm8916
>  	msm8974
>  	msm8996
> +	msm8992

What about 8994 and 8994v2?

>  
>  The 'board' element must be one of the following strings:
>  
> -- 
> 2.6.1
> 
