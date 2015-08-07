From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Fri, 07 Aug 2015 17:18:10 +0100
Subject: [PATCH v9 0/9] Add simple NVMEM Framework via regmap.
In-Reply-To: <7hwpx7vzyo.fsf@deeprootsystems.com>
References: <1437995567-11203-1-git-send-email-srinivas.kandagatla@linaro.org>
 <7hwpx7vzyo.fsf@deeprootsystems.com>
Message-ID: <55C4DA42.909@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks Kevin,

On 07/08/15 17:13, Kevin Hilman wrote:
> Srinivas Kandagatla <srinivas.kandagatla@linaro.org> writes:
>
>> This patchset adds a new simple NVMEM framework to kernel, and it is tested
>> with various drivers like "QCOM thermal sensors", "QCOM cpr driver",
>> "begal bone cape manager" and few more on the way.
>>
>> Can you please consider this as 4.3 material, AFAIK there are more than 3 drivers
>> depending on this framework which are wating since last 2 merge windows.
>>
>> Should these patches go via ARM-SOC tree or via Greg's tree?
>
> With Greg's ack, we can take this through the arm-soc tree (unless Greg
> wants to queue it, which is fine also.)
>

Greg already merged these patches yesterday on to 
git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-next branch.

Now the patches are available in linux-next for more testing.

--srini
> Can you collect the final Tested-by's and prepare a pull request?
>
> Thanks,
>
> Kevin
>
