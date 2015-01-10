From: david@lang.hm (David Lang)
Date: Fri, 9 Jan 2015 18:51:04 -0800 (PST)
Subject: Linux 3.19-rc3
In-Reply-To: <CA+55aFz74hjhCcdz5J4r-xK4KW7oqNDA3i=jXHW0prGMMwgMvw@mail.gmail.com>
References: <CA+55aFwsxoyLb9OWMSCL3doe_cz_EQtKsEFCyPUYn_T87pbz0A@mail.gmail.com>
 <54AE7D53.2020305@redhat.com>
 <20150108134520.GC14200@e104818-lin.cambridge.arm.com>
 <54AEBE84.6090307@redhat.com>
 <20150108173408.GF17290@e104818-lin.cambridge.arm.com>
 <54AED10C.7090305@redhat.com>
 <CA+55aFwpwkjRnTzBe2K0y+2DOH1F=5SpJkYe=P5z8ps5_1PQHQ@mail.gmail.com>
 <20150109232707.GA6325@e104818-lin.cambridge.arm.com>
 <20150110003540.GA32037@node.dhcp.inet.fi>
 <CA+55aFz74hjhCcdz5J4r-xK4KW7oqNDA3i=jXHW0prGMMwgMvw@mail.gmail.com>
Message-ID: <alpine.DEB.2.02.1501091849250.3078@nftneq.ynat.uz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 9 Jan 2015, Linus Torvalds wrote:

> Big pages are a bad bad bad idea. They work fine for databases, and
> that's pretty much just about it. I'm sure there are some other loads,
> but they are few and far between.

what about a dedicated virtualization host (where your workload is a handful of 
virtual machines), would the file cache issue still be overwelming, even though 
it's the virtual machines accessing things?

David Lang
