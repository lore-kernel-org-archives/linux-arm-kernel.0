From: acourbot@nvidia.com (Alex Courbot)
Date: Tue, 19 Feb 2013 12:28:34 +0900
Subject: [RFC PATCH 1/9] ARM: dt: t30 cardhu: add dt entry for lm90
In-Reply-To: <1361187031-3679-2-git-send-email-wni@nvidia.com>
References: <1361187031-3679-1-git-send-email-wni@nvidia.com>
 <1361187031-3679-2-git-send-email-wni@nvidia.com>
Message-ID: <5122F162.9030103@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/18/2013 08:30 PM, Wei Ni wrote:
> Enable thermal sensor lm90 in the dts file.

Acked-by: Alexandre Courbot <acourbot@nvidia.com>

Btw, shouldn't this patch come last, after all the changes you did to 
lm90? If you keep the current order, you will need to ensure that the 
device performs as expected on Cardhu for each of the remaining patches 
of the series. It is probably safer to just move this one at the end to 
avoid trouble.

Alex.
