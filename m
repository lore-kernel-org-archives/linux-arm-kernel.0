From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Tue, 26 Jun 2018 09:53:59 +0100
Subject: [PATCH 03/11] ASoC: q6afe: dt-bindings: add compatible string to
 dais
In-Reply-To: <20180625180130.GC10876@centauri.lan>
References: <20180625143115.8346-1-srinivas.kandagatla@linaro.org>
 <20180625143115.8346-4-srinivas.kandagatla@linaro.org>
 <20180625180130.GC10876@centauri.lan>
Message-ID: <70ad3f74-3fb3-af04-3515-5a593077b82a@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 25/06/18 19:01, Niklas Cassel wrote:
>> @ -103,6 +108,7 @@ q6afe at 4 {
>>   		#sound-dai-cells = <1>;
>>   		#address-cells = <1>;
>>   		#size-cells = <0>;
>> +		compatible = "qcom,q6afe-dais";
> Perhaps have the compatible before #sound-dai-cells
> (and #size-cells, #address-cells) like in two previous
> patches.
> 
Sure, Will fix this in next version!
thanks,
srini
