From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 14 Dec 2017 10:52:22 +0530
Subject: [PATCH V4 09/12] boot_constraint: Add earlycon helper
In-Reply-To: <20171213094450.GD13194@kroah.com>
References: <cover.1509284255.git.viresh.kumar@linaro.org>
 <f32e9a84a985e36cbff76df73faf0e3966d90ada.1509284255.git.viresh.kumar@linaro.org>
 <20171213094450.GD13194@kroah.com>
Message-ID: <20171214052222.GW3322@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13-12-17, 10:44, Greg Kroah-Hartman wrote:
> And this feels really odd, does it really save any work for the
> individual "constraint" to check for this option?  I'm all for helper
> functions, but this feels like more work than it's worth...

Ok, will move this code to individual platform driver files for now.

-- 
viresh
