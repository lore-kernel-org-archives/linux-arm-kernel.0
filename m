From: khilman@kernel.org (Kevin Hilman)
Date: Fri, 07 Aug 2015 09:13:35 -0700
Subject: [PATCH v9 0/9] Add simple NVMEM Framework via regmap.
In-Reply-To: <1437995567-11203-1-git-send-email-srinivas.kandagatla@linaro.org>
 (Srinivas Kandagatla's message of "Mon, 27 Jul 2015 12:12:47 +0100")
References: <1437995567-11203-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <7hwpx7vzyo.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Srinivas Kandagatla <srinivas.kandagatla@linaro.org> writes:

> This patchset adds a new simple NVMEM framework to kernel, and it is tested
> with various drivers like "QCOM thermal sensors", "QCOM cpr driver",
> "begal bone cape manager" and few more on the way.
>
> Can you please consider this as 4.3 material, AFAIK there are more than 3 drivers
> depending on this framework which are wating since last 2 merge windows.
>
> Should these patches go via ARM-SOC tree or via Greg's tree?

With Greg's ack, we can take this through the arm-soc tree (unless Greg
wants to queue it, which is fine also.)

Can you collect the final Tested-by's and prepare a pull request?

Thanks,

Kevin
