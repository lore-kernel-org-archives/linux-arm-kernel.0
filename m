From: cdall@cs.columbia.edu (Christoffer Dall)
Date: Tue, 14 May 2013 10:05:00 -0700
Subject: [PATCH v2 3/5] ARM: KVM: relax cache maintainance when building
 page tables
In-Reply-To: <20130513085802.GA24455@mudshark.cambridge.arm.com>
References: <1367505542-2231-1-git-send-email-marc.zyngier@arm.com>
 <1367505542-2231-4-git-send-email-marc.zyngier@arm.com>
 <20130502150355.GA25022@mudshark.cambridge.arm.com>
 <CAEDV+gJwYpHzehWZci2bmgYedJoBxMOGZFhjGeGRQ_cT8TKkyw@mail.gmail.com>
 <20130502151753.GB25022@mudshark.cambridge.arm.com>
 <20130513051737.GB64337@ubuntu>
 <20130513085802.GA24455@mudshark.cambridge.arm.com>
Message-ID: <CAEDV+gJr4wgAL=2DeJptmGM=NbHZvgxFcY3bPzOWUJph1zuBSA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 13, 2013 at 1:58 AM, Will Deacon <will.deacon@arm.com> wrote:
> On Mon, May 13, 2013 at 06:17:37AM +0100, Christoffer Dall wrote:
>> On Thu, May 02, 2013 at 04:17:53PM +0100, Will Deacon wrote:
>> > or just *pte = XX;
>> >
>> That won't work with STRICT_M_TYPECHECKS though will it?
>
> Depends if XX is a pte_t or not :)
>
this is silly :)
