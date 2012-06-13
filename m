From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 12 Jun 2012 22:17:36 -0300
Subject: [PATCH v2] usb: fsl_udc: errata - postpone freeing current dTD
In-Reply-To: <1339530031.3454.16.camel@mars>
References: <20120410021151.GB23044@lovely.krouter>
 <20120411073918.GA9180@lovely.krouter>
 <CAOMZO5C729Ki0Bequ+s1nnrgt4NZWvwg3Wnjk4kHp=d9BtkeXw@mail.gmail.com>
 <20120509000221.GA19525@lovely.krouter>
 <20120513225126.GA3683@lovely.krouter>
 <20120514042142.GD9750@kroah.com> <20120520231724.GA7941@mars>
 <F281D0F91ED19E4D8E63A7504E8A649803BB1E25@039-SN2MPN1-023.039d.mgd.msft.net>
 <1337583221.3394.21.camel@mars> <20120521065722.GA4363@mars>
 <20120521190450.GA27492@arwen.pp.htv.fi>
 <1338809424.3371.20.camel@mars> <1338809853.3371.31.camel@mars>
 <CAOMZO5B7+Qy06m7O=v1M3vt7to7ciKOhQOihVgAEf+utntvw4w@mail.gmail.com>
 <1339530031.3454.16.camel@mars>
Message-ID: <CAOMZO5CitYj+R+r=Z-ovRKO-kWaPPxBedY7WpKj2-SAk5WAS=w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 12, 2012 at 4:40 PM, Christoph Fritz
<chf.fritz@googlemail.com> wrote:

> Thanks for your patch. It does indeed load
> "Freescale High-Speed USB SOC Device Controller driver (Apr 20, 2007)"
> fine - but now when I want to use it:
>
> modprobe g_ether
> [ ? 17.099363] g_ether gadget: using random self ethernet address
> [ ? 17.105316] g_ether gadget: using random host ethernet address
> [ ? 17.111974] usb0: MAC 1a:c7:9e:76:cc:45
> [ ? 17.115866] usb0: HOST MAC 66:a2:4a:0a:46:17
> [ ? 17.120199] g_ether gadget: Ethernet Gadget, version: Memorial Day 2008
> [ ? 17.126861] g_ether gadget: g_ether ready
>
> these are "the last words": System hangs completely. Same behavior with
> g_serial (these two I've tested).

Ok, I just sent a new patch to the linux-usb mailing list.

Tested it on a mx31 and mx51 and it probed g_ether fine. I don't have
a mx35 handy.

>
> Currently I can't investigate this further, not because of a bug - but a
> flu.

Hope you get better soon.

Regards,

Fabio Estevam
