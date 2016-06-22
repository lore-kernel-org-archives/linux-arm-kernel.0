From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 22 Jun 2016 14:06:21 +0100
Subject: [PATCH v2 1/8] arm64: dts: db820c: add basic board support
In-Reply-To: <1466529769-2674-2-git-send-email-srinivas.kandagatla@linaro.org>
References: <1466529769-2674-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1466529769-2674-2-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <20160622130621.GB28950@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 21, 2016 at 06:22:42PM +0100, Srinivas Kandagatla wrote:
> +	chosen {
> +		stdout-path = "serial0";
> +	};

Please add the configuration (e.g. make this "serial0:115200n8"), as per
Documentation/devicetree/bindings/chosen.txt, so that we're not relying
on implicit defaults.

Otherwise this looks ok.

Thanks,
Mark.
