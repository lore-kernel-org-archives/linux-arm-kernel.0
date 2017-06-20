From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Tue, 20 Jun 2017 12:19:20 +0200
Subject: [PATCH 2/2] pinctrl: samsung: Consistently use unsigned instead
 of u32 for nr_banks
In-Reply-To: <20170615163316.6444-2-krzk@kernel.org>
References: <20170615163316.6444-1-krzk@kernel.org>
 <CGME20170615163343epcas2p35150e861d333a98fa22384bcffcf1523@epcas2p3.samsung.com>
 <20170615163316.6444-2-krzk@kernel.org>
Message-ID: <67234130-5861-5c62-8753-69107d0a3990@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/15/2017 06:33 PM, Krzysztof Kozlowski wrote:
> Unlike for other countable members, the driver used u32 for number of
> banks (nr_banks).  There is no specific need for using fixed-width
> integer in this particular place.  Make it consistent.
> 
> Signed-off-by: Krzysztof Kozlowski<krzk@kernel.org>

Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com>

-- 
Regards,
Sylwester
