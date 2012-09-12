From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 12 Sep 2012 14:57:33 -0600
Subject: [PATCH v3 6/9] ARM: mvebu: add pinctrl device in DT for Armada
 370/XP SoCs
In-Reply-To: <20120912085652.21d3232f@skate>
References: <1345623750-10645-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1347266386-16229-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1347266386-16229-7-git-send-email-sebastian.hesselbarth@gmail.com>
 <504FB9D7.3030205@wwwdotorg.org> <20120912085652.21d3232f@skate>
Message-ID: <5050F73D.8050701@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/12/2012 12:56 AM, Thomas Petazzoni wrote:
> Le Tue, 11 Sep 2012 16:23:19 -0600,
> Stephen Warren <swarren@wwwdotorg.org> a ?crit :
> 
>> On 09/10/2012 02:39 AM, Sebastian Hesselbarth wrote:
>>> From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
>>>
>>> The Armada 370 and XP SoCs have configurable muxing for a certain
>>> number of their pins, controlled through a pinctrl driver.
>>
>> Hmmm. I'd be tempted just to put the entire node definition there;
>> putting in a .dtsi file just to share the reg property doesn't seem
>> especially useful.
> 
> When you say "here" you're mentioning the SoC-specific .dtsi files (i.e

(s/here/there I assume).

> the ones in PATCH 7/9 and PATCH 8/9), correct?

Yes, I believe so.
