From: woogyom.kim@gmail.com (Milo Kim)
Date: Wed, 24 Aug 2016 16:21:28 +0900
Subject: [PATCH v2 3/4] gpu: drm: exynos_hdmi: Use consolidated function
 on binding DDC DT property
In-Reply-To: <a6d2e6cc-d491-fdd4-8c76-5425ec42ba80@samsung.com>
References: <1472005524-3489-1-git-send-email-woogyom.kim@gmail.com>
 <1472005524-3489-4-git-send-email-woogyom.kim@gmail.com>
 <a6d2e6cc-d491-fdd4-8c76-5425ec42ba80@samsung.com>
Message-ID: <9d5bf0cd-44f1-2028-7831-6828e43984d1@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrzej,

On 08/24/2016 02:55 PM, Andrzej Hajda wrote:
> This is mistake introduced  by other patch, of_node_put should be called on
> np, after calling of_find_i2c_adapter_by_node. You can fix it in your
> patch as well.
> I think you can move of_find_i2c_adapter_by_node also to this function and
> rename it to sth like hdmi_get_ddc_adapter, this way you will enclose
> whole logic
> of getting resource into one function.

Agree, let me prepare next patch-set. Thanks!

Best regards,
Milo
