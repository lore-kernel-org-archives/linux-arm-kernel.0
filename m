From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Wed, 25 Mar 2015 12:47:50 +0100
Subject: [GIT PULL] : ARM cpuidle changes for 4.1
In-Reply-To: <55127A53.8050206@linaro.org>
References: <55127A53.8050206@linaro.org>
Message-ID: <3700462.Yl2LKsK0sW@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, March 25, 2015 10:05:23 AM Daniel Lezcano wrote:
> 
> Hi Rafael,
> 
> this PR request has the following content:
> 
>   - Removed the duplicate header inclusion (Daniel Lezcano).
> 
>   - Unified the generic cpuidle ARM driver with ARM64. Each platform can 
> now define their 'enable-method' in the DT thus allowing to split the 
> low level PM code from the generic cpuidle framework (Daniel Lezcano).
> 
>   - Allowed the generic ARM cpuidle driver to register per device and 
> prevent to register the cpuidle device when the underlying hardware is 
> misconfigured or an error occurs, thus allowing to fail gracefully 
> (Daniel Lezcano).
> 
> Thanks !

Pulled, thanks!

Rafael
