From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Sat, 2 Jun 2018 00:35:31 +0100
Subject: [PATCH] of: platform: stop accessing invalid dev in
 of_platform_device_destroy
In-Reply-To: <20180601225822.23439-1-srinivas.kandagatla@linaro.org>
References: <20180601225822.23439-1-srinivas.kandagatla@linaro.org>
Message-ID: <3f925507-bd67-a73d-586e-0458038a5832@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 01/06/18 23:58, Srinivas Kandagatla wrote:
>   
> -	of_node_clear_flag(dev->of_node, OF_POPULATED);
> -	of_node_clear_flag(dev->of_node, OF_POPULATED_BUS);
This change seems to have a side effect during re-probing. I will dig in 
bit more to see how best it can be fixed.

thanks,
srini
