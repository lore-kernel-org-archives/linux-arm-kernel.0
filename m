From: pierre-yves.mordret@st.com (Pierre Yves MORDRET)
Date: Wed, 30 Aug 2017 10:02:56 +0200
Subject: [PATCH v3 2/5] dmaengine: Add STM32 DMAMUX driver
In-Reply-To: <bbfbf048-9d4d-8714-d607-4d02088170d8@ti.com>
References: <1499343623-5964-1-git-send-email-pierre-yves.mordret@st.com>
 <20170722065133.GT3053@localhost>
 <2b916330-9b65-f4d5-817f-79b66cc236b3@st.com>
 <20170726052930.GF3053@localhost>
 <f2908e38-dc4d-3886-4058-52a7ad845415@st.com>
 <20170731123157.GJ3053@localhost>
 <e3a76a50-4160-d111-cce9-132b46b66c33@st.com>
 <20170802045522.GU3053@localhost>
 <7d2091fe-a2e5-78bb-b63d-9cb66bdb7e84@ti.com>
 <7bcad698-fa1a-3dc2-e918-4400639ca6d7@st.com>
 <47ceba83-1097-072e-bed6-d1964bce7a25@ti.com>
 <0e16a519-3d60-f683-5517-12a520e0e521@st.com>
 <f0db566e-5613-8914-e070-915c8c4d9b9f@ti.com>
 <71b7ef2a-d745-d16b-4538-567c856cce9a@st.com>
 <401305f0-15d8-1996-60d6-69c13cbacc06@ti.com>
 <58bf2f7c-faf1-d1e9-3c87-d7964d1ba3d4@st.com>
 <6e8e19f1-8d0f-183b-e02f-1ec8c4dd57b3@ti.com>
 <f7ddd927-5db3-e1b1-b7f1-94050b508298@st.com>
 <d1cc3cbb-c4aa-2acc-91ff-1d6713cb8867@ti.com>
 <ea66ba14-fe18-cb83-5989-8ae7b3ab50c6@st.com>
 <bbfbf048-9d4d-8714-d607-4d02088170d8@ti.com>
Message-ID: <5cc55253-cfe8-270e-895a-135eab782446@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 08/28/2017 01:48 PM, Peter Ujfalusi wrote:
> 
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
> 

Thanks for your invaluable inputs. This is more clear now and revise my driver

> 
> I would not bother with mixed use case here, I would just make it
> mandatory to go via the router.
> 

I couldn't agree more. But it seems to me there is a flaw here. This should be
possible though. I will likely look at that later on.

A new revision of this driver will come soon ;)

> 
> - P?ter
> 
Py
