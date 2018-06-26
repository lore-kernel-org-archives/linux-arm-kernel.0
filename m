From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Tue, 26 Jun 2018 09:53:20 +0100
Subject: [PATCH 11/11] ASoC: qdsp6: q6routing: add proper error check
In-Reply-To: <20180625180454.GI10876@centauri.lan>
References: <20180625143115.8346-1-srinivas.kandagatla@linaro.org>
 <20180625143115.8346-12-srinivas.kandagatla@linaro.org>
 <20180625180454.GI10876@centauri.lan>
Message-ID: <f2ee3dfa-6844-074a-178a-094c02a1e130@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 25/06/18 19:04, Niklas Cassel wrote:
> On Mon, Jun 25, 2018 at 03:31:15PM +0100, Srinivas Kandagatla wrote:
>> q6adm_open can return error pointer or a null in error cases.
>> Fix this check this.
> Instead of "Fix this check this.", how about "Fix the return handling."

Thanks,  I will reword this!
--srini
> 
