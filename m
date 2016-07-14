From: pbonzini@redhat.com (Paolo Bonzini)
Date: Thu, 14 Jul 2016 13:01:30 +0200
Subject: [PATCH v9 00/17] KVM: arm64: GICv3 ITS emulation
In-Reply-To: <57876EE1.3020905@arm.com>
References: <20160713015909.28793-1-andre.przywara@arm.com>
 <57876EE1.3020905@arm.com>
Message-ID: <bbc2c000-34c9-da9b-63ed-f322a18ad7fa@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 14/07/2016 12:52, Marc Zyngier wrote:
> I'm done with that round. Couple of annoying bugs, and still a bunch of
> loose ends to be tied. Timing wise, this is getting pretty tight for
> 4.8, so unless you address the comments very quickly, it will be a miss
> again.
> 
> My plan is to cut the 4.8 branch at the end of this week, so you have
> until then to repost something that I can stick into -next.

FYI I'm on vacation on July 24-31, and will send the pull request to
Linus around Aug 2.  If necessary you can delay things by one more week
and send a pull request to Radim around the end of July after the merge
window has officially started already.

Paolo
