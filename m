From: will.deacon@arm.com (Will Deacon)
Date: Mon, 13 May 2013 09:58:03 +0100
Subject: [PATCH v2 3/5] ARM: KVM: relax cache maintainance when building
 page tables
In-Reply-To: <20130513051737.GB64337@ubuntu>
References: <1367505542-2231-1-git-send-email-marc.zyngier@arm.com>
 <1367505542-2231-4-git-send-email-marc.zyngier@arm.com>
 <20130502150355.GA25022@mudshark.cambridge.arm.com>
 <CAEDV+gJwYpHzehWZci2bmgYedJoBxMOGZFhjGeGRQ_cT8TKkyw@mail.gmail.com>
 <20130502151753.GB25022@mudshark.cambridge.arm.com>
 <20130513051737.GB64337@ubuntu>
Message-ID: <20130513085802.GA24455@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 13, 2013 at 06:17:37AM +0100, Christoffer Dall wrote:
> On Thu, May 02, 2013 at 04:17:53PM +0100, Will Deacon wrote:
> > or just *pte = XX;
> > 
> That won't work with STRICT_M_TYPECHECKS though will it?

Depends if XX is a pte_t or not :)

Will
