From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 19 Apr 2012 09:31:11 -0600
Subject: [PATCH 3/3] ARM: dt: tegra_ventana: als and proximity sensor
 isl29018 support
In-Reply-To: <4F8FD709.60308@nvidia.com>
References: <1334645155-13799-1-git-send-email-ldewangan@nvidia.com>
 <1334645155-13799-4-git-send-email-ldewangan@nvidia.com>
 <4F8DF01D.9040900@wwwdotorg.org> <4F8FD709.60308@nvidia.com>
Message-ID: <4F902FBF.8010607@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/19/2012 03:12 AM, Laxman Dewangan wrote:
> On Wednesday 18 April 2012 04:05 AM, Stephen Warren wrote:
>> On 04/17/2012 12:45 AM, Laxman Dewangan wrote:
>>> Add the device info for ALS and proximity sensor isl29018.
>>
>> a) Perhaps the vendor prefix should be "isil" not "isl". Olof, can you
>> please comment here?
> 
> Any comments on this? I think "isil" is good as it is the symbol in
> nasdaq also: Intersil Corporation (ISIL).
> If no objection than I can send my next version of patch ;)

Yes, the idea is to use stock ticker symbols where possible, so it
sounds like isil is the way to go.
