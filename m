From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Wed, 21 Jan 2015 14:41:00 +0200
Subject: [PATCH v7 1/4] Documentation: dt: add common bindings for
 hwspinlock
In-Reply-To: <20150120180548.GK7718@atomide.com>
References: <1421269101-51105-1-git-send-email-s-anna@ti.com>
 <1421269101-51105-2-git-send-email-s-anna@ti.com>
 <20150115135201.GG16217@leverpostej>
 <20150115135556.GH16217@leverpostej>
 <CAL_JsqL2LZAooMk-V8+xeF2g6acZE21M+-OBRw8aEVa-5wVHuQ@mail.gmail.com>
 <CAK=WgbYQ=BbinqJ5fsw2Y+FKdy=nasLsw9mX8pw6S_o3owy9-g@mail.gmail.com>
 <20150116101746.GA21809@leverpostej>
 <CAK=WgbYBqPoUm9byx0du_g5ZmHdYaUVLpSPZYHoCVzNoatNKpw@mail.gmail.com>
 <20150120180548.GK7718@atomide.com>
Message-ID: <CAK=WgbZGGtwmQwzWumjpYOsYHTt8vPQpTraABwJBsv5VXOmJ_Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 20, 2015 at 8:05 PM, Tony Lindgren <tony@atomide.com> wrote:
> How about default to Linux id space and allow overriding that with
> a module param option if needed?

I'm not sure I'm following.

If the main point of contention is the base_id field, I'm also fine
with removing it entirely, as I'm not aware of any actual user for it
(Suman please confirm?).

Mark? Rob? Will you accept Suman's patches if the base_id field is removed?

Thanks,
Ohad.
