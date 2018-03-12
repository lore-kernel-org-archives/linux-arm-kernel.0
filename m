From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Mon, 12 Mar 2018 19:54:20 +0100
Subject: [PATCH v3 2/2] ASoC: samsung: Add HDMI audio support for Snow
In-Reply-To: <20180312184939.11327-2-s.nawrocki@samsung.com>
References: <20180312184939.11327-1-s.nawrocki@samsung.com>
 <CGME20180312185000epcas1p2ae13436139bee76311206ac3fd74267c@epcas1p2.samsung.com>
 <20180312184939.11327-2-s.nawrocki@samsung.com>
Message-ID: <06ddf7cf-02dc-f50c-37bb-157f4d643c07@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/12/2018 07:49 PM, Sylwester Nawrocki wrote:
> This patch updates the driver so, in addition to current DT bindings, it
> also can also use the new DT bindings with cpu, codec subnodes which allow
> to support sound on the HDMI interface.
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>

I've forgotten to add Krzysztof's tag:

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
