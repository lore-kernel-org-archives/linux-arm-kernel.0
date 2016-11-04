From: tony@atomide.com (Tony Lindgren)
Date: Fri, 4 Nov 2016 07:58:55 -0700
Subject: [PATCH v2 2/2] power: bq27xxx_battery: add poll interval
 property query
In-Reply-To: <20161104070955.GA3679@amd>
References: <1475092512-30555-3-git-send-email-matt@ranostay.consulting>
 <CAKzfze9uvMvrF=gWph_HKFk_cH0qzRz6Wa2VJafK+H+wdnP0rg@mail.gmail.com>
 <20161024201443.GB5989@amd>
 <CAKzfze_rv29gwuBGctwTONyw8Oy6fwE+xcN0HMh-ZPB47HKzuQ@mail.gmail.com>
 <CAJ_EiSRzmQHLP2PTfzsLF4uWgYgCiRGsSk=MHbtOC5rgXnnFpw@mail.gmail.com>
 <20161031213846.GA21014@amd>
 <CAKzfze8Bom1XYRfiix_qYFckMggUD0eJm3Fz=GhNi6H_PBFyXA@mail.gmail.com>
 <20161102082206.GE21488@amd>
 <CAKzfze8d_MZJzR1a6rbwVXCWhb30C5GqFamUt2Viw1CzvyaQxw@mail.gmail.com>
 <20161104070955.GA3679@amd>
Message-ID: <20161104145855.GH21430@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Pavel Machek <pavel@ucw.cz> [161104 00:10]:
> On Thu 2016-11-03 22:00:56, Matt Ranostay wrote:
> Do you actually have hardware with more than one bq27xxx?

I can at least see the twl4030 battery/charger features
being used together with some bq device to monitor the
battery state. Not sure if that counts as multiple
instances here though :)

Regards,

Tony
