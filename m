From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Tue, 20 Jun 2017 14:11:23 +0200
Subject: [PATCH 1/2] pinctrl: samsung: Use unsigned int for number of
 controller IO mem resources
In-Reply-To: <20170615163316.6444-1-krzk@kernel.org>
References: <CGME20170615163507epcas2p4afd786730362715894d5a178a4ad2040@epcas2p4.samsung.com>
 <20170615163316.6444-1-krzk@kernel.org>
Message-ID: <9683ed1b-3b8c-e110-20c9-ef86d887a8ac@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/15/2017 06:33 PM, Krzysztof Kozlowski wrote:
> Number of IO memory resources cannot be negative obviously and the
> driver depends silently on this (by iterating from 0 to
> nr_ext_resources+1).  Make this requirement explicit.
> 
> Signed-off-by: Krzysztof Kozlowski<krzk@kernel.org>

Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com>

-- 
Regards,
Sylwester
