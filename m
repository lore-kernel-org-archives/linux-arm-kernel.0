From: davidb@codeaurora.org (David Brown)
Date: Wed, 23 May 2012 10:48:03 -0700
Subject: [PATCH v5 1/4] regulator: helper routine to extract
 regulator_init_data
In-Reply-To: <1321615040-13257-2-git-send-email-rnayak@ti.com>
References: <1321615040-13257-1-git-send-email-rnayak@ti.com>
 <1321615040-13257-2-git-send-email-rnayak@ti.com>
Message-ID: <20120523174803.GA18609@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 18, 2011 at 04:47:17PM +0530, Rajendra Nayak wrote:

> +	xyzreg: regulator at 0 {
> +		regulator-min-microvolt = <1000000>;
> +		regulator-max-microvolt = <2500000>;
> +		regulator-always-on;
> +		vin-supply = <&vin>;
> +	};

Just noticed this, but the '@0' shouldn't be on the name, since there
isn't a reg attribute on this node.  Perhaps it should be
"regulator-xyz"?

David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
