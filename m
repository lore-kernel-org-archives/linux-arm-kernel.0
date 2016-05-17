From: dyoung@redhat.com (Dave Young)
Date: Tue, 17 May 2016 13:42:16 +0800
Subject: [PATCH v15 00/20] arm64 kexec kernel patches v15
In-Reply-To: <1459535954.20121.3.camel@infradead.org>
References: <cover.1457977401.git.geoff@infradead.org>
 <20160401015947.GA3835@dhcp-128-65.nay.redhat.com>
 <1459535954.20121.3.camel@infradead.org>
Message-ID: <20160517054216.GA12543@dhcp-128-65.nay.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marc, it has been discussed for long time, I think kdump code can be
logically splitted from this series so that we can get the kexec
done first? 

On 04/01/16 at 11:39am, Geoff Levand wrote:
> Hi,
> 
> On Fri, 2016-04-01 at 09:59 +0800, Dave Young wrote:
> > Geoff, for easier to review maybe you can send kexec patches first
> > then AKASHI Takahiro
> > can send the kdump patches as a standalone patchset?
> 
> Marc Zyngier specifically asked for an integrated set
> of patches for easier review.  I will keep it that way
> for now.
> 
> -Geoff
