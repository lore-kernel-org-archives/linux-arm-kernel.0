From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Wed, 9 May 2018 09:08:01 +0100
Subject: [PATCH v7 13/24] ASoC: qdsp6: q6adm: Add q6adm driver
In-Reply-To: <e9a97387-2bd7-9733-5946-50091aec93a0@codeaurora.org>
References: <20180501120820.11016-1-srinivas.kandagatla@linaro.org>
 <20180501120820.11016-14-srinivas.kandagatla@linaro.org>
 <e9a97387-2bd7-9733-5946-50091aec93a0@codeaurora.org>
Message-ID: <d85db592-903a-2da3-4ff1-e153b3dde2cb@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 09/05/18 08:55, Banajit Goswami wrote:
>> + */
>> +int q6adm_close(struct device *dev, int port_id, int perf_mode, int 
>> copp_idx)
> perf_mode unused param. Remove for now. Can be added back when needed.
> 
> Otherwise LGTM.
Yep, will do that thanks.

--srini
> Once fixed above, add acked-by
> Acked-by: Banajit Goswami <bgoswami@codeaurora.org>
