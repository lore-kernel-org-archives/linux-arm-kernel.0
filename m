From: peter.griffin@linaro.org (Peter Griffin)
Date: Tue, 23 Sep 2014 19:05:39 +0100
Subject: [STLinux Kernel] [PATCH 3/3] media: st-rc: Remove .owner field
 for driver
In-Reply-To: <1411424568-12803-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1411424501-12673-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1411424568-12803-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <20140923180539.GB3430@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 22 Sep 2014, Srinivas Kandagatla wrote:

> There is no need to init .owner field.
> 
> Based on the patch from Peter Griffin <peter.griffin@linaro.org>
> "mmc: remove .owner field for drivers using module_platform_driver"
> 
> This patch removes the superflous .owner field for drivers which
> use the module_platform_driver API, as this is overriden in
> platform_driver_register anyway."
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Acked by: 
    Acked-by: Peter Griffin <peter.griffin@linaro.org>
