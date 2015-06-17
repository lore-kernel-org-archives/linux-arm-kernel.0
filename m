From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 17 Jun 2015 20:12:23 +0530
Subject: [PATCH V7 2/3] OPP: Allow multiple OPP tables to be passed via DT
In-Reply-To: <CAL_Jsq+SdgAf7=Yq7Jk_1d9jTpAOLCEuEDCZvD=-h=2MWsNfFw@mail.gmail.com>
References: <cover.1433434659.git.viresh.kumar@linaro.org>
 <263c128844f5a3c9280c8be71f6c9eb1869a5188.1433434659.git.viresh.kumar@linaro.org>
 <CAL_Jsq+EOOeQw42wZi+H82ovLn8LcQUuK9HGT+FvewdhTf7Q1w@mail.gmail.com>
 <20150617133314.GB15153@linux>
 <CAL_Jsq+SdgAf7=Yq7Jk_1d9jTpAOLCEuEDCZvD=-h=2MWsNfFw@mail.gmail.com>
Message-ID: <20150617144223.GC15153@linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17-06-15, 08:47, Rob Herring wrote:
> Defined order is a key part of DT bindings. We solve the variable
> length problem with name lists associated with variable length
> property like:
> 
> operating-point-names = "slow", "fast";

I agree that we should have used this..

> I'm not a fan of doing this if we can avoid it, but we should at least
> follow the same pattern. Don't send me a patch with that yet, I want
> to hear from Stephen.

Good that you told me to stop :)

> You can also use "status" to disable specific tables rather than
> removing from the list.

Hmmm, right. That's far better.

-- 
viresh
