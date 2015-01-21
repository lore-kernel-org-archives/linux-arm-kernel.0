From: s-anna@ti.com (Suman Anna)
Date: Wed, 21 Jan 2015 11:56:37 -0600
Subject: [PATCH v7 1/4] Documentation: dt: add common bindings for
 hwspinlock
In-Reply-To: <CAK=WgbZGGtwmQwzWumjpYOsYHTt8vPQpTraABwJBsv5VXOmJ_Q@mail.gmail.com>
References: <1421269101-51105-1-git-send-email-s-anna@ti.com>
 <1421269101-51105-2-git-send-email-s-anna@ti.com>
 <20150115135201.GG16217@leverpostej> <20150115135556.GH16217@leverpostej>
 <CAL_JsqL2LZAooMk-V8+xeF2g6acZE21M+-OBRw8aEVa-5wVHuQ@mail.gmail.com>
 <CAK=WgbYQ=BbinqJ5fsw2Y+FKdy=nasLsw9mX8pw6S_o3owy9-g@mail.gmail.com>
 <20150116101746.GA21809@leverpostej>
 <CAK=WgbYBqPoUm9byx0du_g5ZmHdYaUVLpSPZYHoCVzNoatNKpw@mail.gmail.com>
 <20150120180548.GK7718@atomide.com>
 <CAK=WgbZGGtwmQwzWumjpYOsYHTt8vPQpTraABwJBsv5VXOmJ_Q@mail.gmail.com>
Message-ID: <54BFE855.3090200@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/21/2015 06:41 AM, Ohad Ben-Cohen wrote:
> On Tue, Jan 20, 2015 at 8:05 PM, Tony Lindgren <tony@atomide.com> wrote:
>> How about default to Linux id space and allow overriding that with
>> a module param option if needed?
> 
> I'm not sure I'm following.
> 
> If the main point of contention is the base_id field, I'm also fine
> with removing it entirely, as I'm not aware of any actual user for it
> (Suman please confirm?).

Yeah, well the current implementations that I am aware of only have a
single bank, so all of them would be using a value of 0. I am yet to see
a platform with multiple instances where the property really makes a
difference. v7 has the property mandatory, so all the implementations
would need to define this value even if it is 0.

regards
Suman

> 
> Mark? Rob? Will you accept Suman's patches if the base_id field is removed?
> 
> Thanks,
> Ohad.
> 
