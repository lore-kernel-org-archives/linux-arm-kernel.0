From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 4 Dec 2013 08:10:21 +0000
Subject: [PATCH v4 1/3] mfd: tps6586x: add version detection
In-Reply-To: <77384d24810d9a22fc04cad6f7468f54a9cbaafe.1386108712.git.stefan@agner.ch>
References: <cover.1386108712.git.stefan@agner.ch>
 <77384d24810d9a22fc04cad6f7468f54a9cbaafe.1386108712.git.stefan@agner.ch>
Message-ID: <20131204081021.GB7469@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +int tps6586x_get_version(struct device *dev)
> +{
> +	struct tps6586x *tps6586x = dev_get_drvdata(dev);
> +
> +	return tps6586x->version;
> +}
> +EXPORT_SYMBOL_GPL(tps6586x_get_version);

I thought Mark suggested that this routine was converted to a 'static
inline' and moved into the header? Did you not think this was a good
idea?

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
