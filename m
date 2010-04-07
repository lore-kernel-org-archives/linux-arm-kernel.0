From: jason.mcmullan@netronome.com (Jason McMullan)
Date: Wed, 7 Apr 2010 13:31:09 -0400
Subject: [RFC PATCH v4 0/3] ARM: VFP: Save / restore VFP state on the
	signal handler path
In-Reply-To: <20100407163908.GA20914@localhost>
References: <1269879460-1038-1-git-send-email-imre.deak@nokia.com>
	<1270070606-5732-1-git-send-email-imre.deak@nokia.com>
	<4BBCB1C7.4030407@googlemail.com> <20100407163908.GA20914@localhost>
Message-ID: <y2od91d07041004071031sd73fe549mc5f66ac7a8ce96f4@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 7, 2010 at 12:39 PM, Imre Deak <imre.deak@nokia.com> wrote:
> On Wed, Apr 07, 2010 at 06:24:39PM +0200, ext Dirk Behme wrote:
>> Do you think this is relevant for ARM11 SMP (ARM11 MPCore), too? Or do
>> you think this is necessary only for NEON systems, i.e. Cortex Ax?
>
> I think ARM11 has VFP, so it is relevant for it. This actually means that it's
> enough to provide -mfpu=vfp above..

I know of at least one MPCore (ARM11) SoC where the VFP design option was
not enabled. Keep that in mind.
