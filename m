From: robherring2@gmail.com (Rob Herring)
Date: Thu, 22 Dec 2011 10:01:56 -0600
Subject: [PATCH v2 1/1] dt: reform for_each_property to
 for_each_property_of_node
In-Reply-To: <1324556364-26188-1-git-send-email-b29396@freescale.com>
References: <1324556364-26188-1-git-send-email-b29396@freescale.com>
Message-ID: <4EF35474.2010209@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/22/2011 06:19 AM, Dong Aisheng wrote:
> From: Dong Aisheng <dong.aisheng@linaro.org>
> 
> Make this macro easier to use(do not need to pass properties, a node is
> enough), also change to a more sensible name as for_each_child_of_node.
> 
> Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Rob Herring <rob.herring@calxeda.com>
> ---
> Changes v1->v2:
> - Fix a typo error (micro->macro)
> 

Applied.

Rob
