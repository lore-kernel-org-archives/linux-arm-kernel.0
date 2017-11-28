From: tony@atomide.com (Tony Lindgren)
Date: Tue, 28 Nov 2017 08:00:57 -0800
Subject: [PATCH v2 2/4] DTS: GTA04: fix panel compatibility string
In-Reply-To: <F14B3797-8154-4958-82AB-8E39C75BB97B@goldelico.com>
References: <cover.1510822218.git.hns@goldelico.com>
 <09d975dd62afa1dfa43d94079cc9a44731af4b3b.1510822218.git.hns@goldelico.com>
 <20171128145727.GY28152@atomide.com>
 <C108B0B6-FED7-44DB-9A18-39E3BE93E586@goldelico.com>
 <20171128151039.GZ28152@atomide.com>
 <F14B3797-8154-4958-82AB-8E39C75BB97B@goldelico.com>
Message-ID: <20171128160057.GB28152@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* H. Nikolaus Schaller <hns@goldelico.com> [171128 15:51]:
> > Am 28.11.2017 um 16:10 schrieb Tony Lindgren <tony@atomide.com>:
> > OK fine dropping both. Please update the description in both dts
> > patches to make it clear they are needed as a fix. Preferrably
> > with a proper fixes tag.
> 
> Well, it is not "needed" in a strong sense since current mainline&stable
> works. It is more a style and consistency fix to use "tpo," everywhere.
> 
> > 
> > Having "We can remove the "omapdss," prefix" in the description sure
> > does not sounds like it's needed as a fix :)
> 
> The description has been improved on -v3.

Thanks.

> > Sounds like maybe these two should be just a single patch for
> > a proper fix?
> 
> Hm. I usually get the feedback to separate DT and driver fixes into
> separate commits... Therefore I submit patch sets in the hope they
> are not picked apart :)

See "both dts patches" part above. Yes the dts patches can and should
be sent separately. In almost every case if the dts patches cannot be
applied separately it means your driver changes are breaking things.

Regards,

Tony
