From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 8 Jul 2015 16:20:54 +0530
Subject: [PATCH v2 0/9] cpufreq: Introduce support for ST's cpufreq
 functionality
In-Reply-To: <1435154348-28840-1-git-send-email-lee.jones@linaro.org>
References: <1435154348-28840-1-git-send-email-lee.jones@linaro.org>
Message-ID: <20150708105054.GB1805@linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24-06-15, 14:58, Lee Jones wrote:
> This driver reads very platform specific information in from Device Tree
> and translates it into frequency tables.  The generic drivers then use the
> tables to conduct frequency and voltage scaling in the normal way.
> 
> There are 'ARM' patches in the set which are not necessarily related to CPUFreq,
> but are required to get it to work.  Anyone who is not interested in general STi
> DT changes can safely ignore these.
> 
> v1 => v2:
>  - CPUFreq is no longer it's own device in DT; instead:
>    - It is probed from the platform area
>    - Key properties have been moved into the CPU's node
>  - Driver is less generic [ST => STI]
>  - Documentation has been updated
>    - Point one (above) has been accounted for
>    - Example of bootloader supplied node has been provided
>  - GPL licensing has been updated to reflected the header
>  - Kconfig disparity has been rectified [bool => tristate]

Sorry for being so late to get back to this.. Was tooo busy :(

-- 
viresh
