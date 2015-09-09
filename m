From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 9 Sep 2015 17:36:20 +0100
Subject: [PATCH v4 2/2] dt: power: st: Provide bindings for ST's OPPs
In-Reply-To: <20150909160212.GJ5266@linux>
References: <20150811151736.GO18282@x1> <20150812110841.GC20238@linux>
 <20150826120628.GZ19409@x1> <20150902080639.GA26744@linux>
 <CAL_JsqKMGp+3Z+oO6E0YYzjTCb=-R_QM=YF=B33NWayWmV057A@mail.gmail.com>
 <20150909062722.GA5266@linux> <20150909075930.GB3260@x1>
 <20150909083031.GB5266@linux> <20150909133930.GE3260@x1>
 <20150909160212.GJ5266@linux>
Message-ID: <20150909163620.GF3260@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > Or have I got the wrong end of the stick?
> > 
> > NB: Note the suggested new property names.
> 
> Yeah, all looks fine to me.

I think these names are better:

  opp-supply-range-name => opp-microvolt-names
  opp-cuts              => opp-supported-hw

Apart from that, the binding is starting to come together.

Let's see what Rob and Stephen have to say about it.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
