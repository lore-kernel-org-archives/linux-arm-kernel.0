From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 31 Jul 2012 15:25:07 +0100
Subject: [PATCH 1/6] ASoC: dapm: If one widget fails, do not force all
 subsequent widgets to fail too
In-Reply-To: <20120731134214.GK4468@opensource.wolfsonmicro.com>
References: <1343741493-17671-1-git-send-email-lee.jones@linaro.org>
 <1343741493-17671-3-git-send-email-lee.jones@linaro.org>
 <20120731134214.GK4468@opensource.wolfsonmicro.com>
Message-ID: <5017EAC3.3080504@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31/07/12 14:42, Mark Brown wrote:
> On Tue, Jul 31, 2012 at 02:31:23PM +0100, Lee Jones wrote:
>> If a list of widgets is provided and one of them fails to be added as
>> a control, the present semantics fail all subsequent widgets. A better
>> solution would be to only fail that widget, but pursue in attempting
>> to add the rest of the list.
>
> You're posting this *again* without bothering to respond to my review
> comments.


I didn't see any comments on this.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
