From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 25 Mar 2015 08:03:56 +0100
Subject: [PATCH 2/2] ARM: cpuidle: Document the code
In-Reply-To: <20150324185144.GB27311@red-moon>
References: <20150323225828.GC15435@e102568-lin.cambridge.arm.com>
 <1427190842-30675-1-git-send-email-daniel.lezcano@linaro.org>
 <1427190842-30675-2-git-send-email-daniel.lezcano@linaro.org>
 <20150324185144.GB27311@red-moon>
Message-ID: <55125DDC.9000901@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/24/2015 07:51 PM, Lorenzo Pieralisi wrote:
> On Tue, Mar 24, 2015 at 09:54:02AM +0000, Daniel Lezcano wrote:
>> Add kernel-doc format documentation in the code.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---

[ ... ]

>> + * Returns:
>> + *  0 on success,
>> + *  -ENODEV if it fails to find the cpu node in the device tree,
>> + *  -EOPNOTSUPP if it does not find a registered cpuidle_ops for this cpu,
>> + *  -ENOENT if it fails to find a enabled-method property,
>
> Ultra-nit: "an enabled-method"
>
>> + *  -ENXIO if the HW reports a failure or a misconfiguration
>
> -ENOMEM is missing.
>
> Apart from these ultraminor changes (and thanks for putting it
> together):
>
> Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>

Thanks for review Lorenzo. I fixed the comment and pushed in my tree for 
4.1.

  -- Daniel

-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
