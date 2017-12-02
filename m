From: peda@axentia.se (Peter Rosin)
Date: Sat, 2 Dec 2017 08:58:38 +0100
Subject: [PATCH 0/2] Add devicetree for Axentia Nattis
In-Reply-To: <CABxcv=k6K8gRDSRu1r6=mELcOQLcNr6EOQGj0Q0wDXrGa58sqw@mail.gmail.com>
References: <20171201224425.5477-1-peda@axentia.se>
 <CABxcv=k6K8gRDSRu1r6=mELcOQLcNr6EOQGj0Q0wDXrGa58sqw@mail.gmail.com>
Message-ID: <e9d88ae6-9c2c-d873-ebad-1054d29b5da8@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017-12-02 02:05, Javier Martinez Canillas wrote:
> Hello Peter,
> 
> On Fri, Dec 1, 2017 at 11:44 PM, Peter Rosin <peda@axentia.se> wrote:
>> Hi!
>>
>> I'd like to add a devicetree for our Nattis to the kernel. The
>> Nattis is a device for showing departures for public transportation
>> (optionally including a text-to-speech module for the visually
>> impaired).
>>
>> I'm a bit unsure if the tfa9879 sound codec binding is needed,
>> but I suppose it belongs in trivial-devices?
>>
> 
> There's a DT binding for this device now:
> 
> https://patchwork.ozlabs.org/patch/816157/

What do you know, thanks for the hint. I even reviewed a followup
patch for that one, so I guess I should have known...

Anyway, I should probably add a #sound-dai-cells entry. v2 coming up.

Cheers,
peda
